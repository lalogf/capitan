require 'roo'
# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string(255)      default("")
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  provider                    :string(255)
#  uid                         :string(255)
#  admin                       :boolean          default(FALSE)
#  dni                         :string(255)
#  code                        :string(255)
#  name                        :string(255)      not null
#  lastname1                   :string(255)      not null
#  lastname2                   :string(255)
#  age                         :integer
#  district                    :string(255)
#  facebook_username           :string(255)
#  phone1                      :string(255)
#  phone2                      :string(255)
#  branch_id                   :integer
#  disable                     :boolean          default(FALSE)
#  my_draft_comments_count     :integer          default(0)
#  my_published_comments_count :integer          default(0)
#  my_comments_count           :integer          default(0)
#  draft_comcoms_count         :integer          default(0)
#  published_comcoms_count     :integer          default(0)
#  deleted_comcoms_count       :integer          default(0)
#  spam_comcoms_count          :integer          default(0)
#  roles_mask                  :integer
#

class User < ActiveRecord::Base
  
  #TODO: ESTO DEBE SALIR PORQUE VAMOS A USAR DISCOURSE U OTRO SISTEMA DE COMENTARIOS
  include TheComments::User
  
  ROLES = %w[student teacher assistant admin].freeze

  after_initialize :set_default_role
  
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  belongs_to :branch
  has_many :answers , :dependent => :destroy
  has_many :pages, through: :answers
  has_many :enrollments, :dependent => :destroy
  has_many :courses, through: :enrollments
  
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :omniauthable, 
         :omniauth_providers => [:github,:facebook]
  
  scope :students, -> (branch_id) { where(branch_id: branch_id, admin: 0, disable: 0) }
  scope :admins, -> (branch_id) { where(branch_id: branch_id, admin: 1, disable: 0) }
  scope :students_and_admins, -> (branch_id) { where(branch_id: branch_id, disable:0) }
  scope :disables, -> (branch_id) { where(branch_id: branch_id, disable: 1) }
  
  validates :code, uniqueness: { case_sensitive: false }
  
  has_attached_file :avatar, 
                    :styles => { :menu => "80x80", :navbar => "35x35" },
                    :url => "/system/:class/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"  
                    
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/   
  
  # TODO: PODER VINCULAR MI CUENTA CON GITHUB, ESTO QUEDO A MEDIAS
  def self.create_from_omniauth(params)
    attributes = {
      name: params['info']['name'],
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end
  
  # MANEJO DE ROLES
  def set_default_role
    roles()
  end  
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end  
  
  #UTILITARIOS
  def full_name
    return "#{name} #{lastname1} #{lastname2}"
  end
  
  def email_required?
    false
  end

  # METODOS DE CONSULTA PARA EL ADMINISTRADOR
  def self.total_score_by_course(course_id)
    User.select(:id,'courses.id as course_id','sum(answers.points) as score')
    .joins(answers: {page: {unit: :course}})
    .where('pages.page_type in (?,?) and courses.id = ? and users.admin = 0','editor','questions',course_id)
    .group('answers.user_id')
    .order('answers.user_id')
  end
  
  def list_activities_scorables(course_id)
    query = "select tb2.user_id, p.id, p.title, p.points,p.question_points * tb1.questions_per_page as question_points, p.auto_corrector, tb2.score, p.page_type
             from pages p 
             join units u on p.unit_id = u.id
             join courses c on u.course_id = c.id
             left join (select p.id as page_id,count(qg.id) as questions_per_page from question_groups qg join pages p on qg.page_id = p.id group by p.id)tb1 on tb1.page_id = p.id
             left join (
             select a.user_id as user_id,p.id as page_id, p.page_type, a.points as score
             from answers a
             join pages p on a.page_id = p.id
             join units u on p.unit_id = u.id
             join courses c on u.course_id = c.id
             join users us on a.user_id = us.id
             where p.page_type in ('editor','questions') and c.id = #{course_id} and us.admin = 0 and us.id = #{self.id}
             order by a.user_id, p.page_type)tb2 on tb2.page_id = p.id
             where p.page_type in ('editor','questions') and c.id = #{course_id}"

    return ActiveRecord::Base.connection.execute(query)
  end
  
  def calculate_test_time()
    answers = self.answers.order(:created_at)
    return !answers.empty? ? (answers.try(:last).try(:created_at) - answers.try(:first).try(:created_at)) : 0
  end
  
  def getEditorAnswers(course_id)
    Answer.joins(page: {unit: :course}).where("pages.page_type = ? and courses.id = ? and answers.user_id = ? ","editor",course_id,self.id)
  end
  
  def getQuestionsAnswers(course_id,selfLearning)
    
    questionsAnswers = []
    question_ids = []
    option_ids = []
    
    answers = Answer.joins(page: {unit: :course}).where("pages.page_type = ? and pages.selfLearning = ? and courses.id = ? and answers.user_id = ? ","questions",selfLearning ? 1 : 0, course_id,self.id)
    answers.each do |answer|
      parts = answer.result.split(";")

      for i in 1...parts.length
        question_id, option_id = parts[i].split("|")
        question_ids << question_id
        option_ids << option_id
      end
    end
    
    questionsGroup = Hash[ QuestionGroup.find(question_ids).map{ |q| [q.id,q] } ]
    options = Hash[ Option.find(option_ids).map{ |o| [o.id,o] } ]
    
    answers.each do |answer|
      parts = answer.result.split(";")
      for i in 1...parts.length
        question_id, option_id = parts[i].split("|")
        questionsAnswers << [questionsGroup[question_id.to_i],options[option_id.to_i],answer]
      end
      
    end
    
    return questionsAnswers
  end
  
  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = User.find_or_initialize_by(code: row["code"])
      if user.update(row.to_hash)
        p "Usuario con codigo #{user.code} actualizado"
      else
        p "USER CODE #{user.code}: #{user.errors.full_messages}"
      end
    end
  end  

end
