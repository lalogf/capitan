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
#  disable                     :boolean          default(FALSE)
#  my_draft_comments_count     :integer          default(0)
#  my_published_comments_count :integer          default(0)
#  my_comments_count           :integer          default(0)
#  draft_comcoms_count         :integer          default(0)
#  published_comcoms_count     :integer          default(0)
#  deleted_comcoms_count       :integer          default(0)
#  spam_comcoms_count          :integer          default(0)
#  roles_mask                  :integer
#  avatar_file_name            :string(255)
#  avatar_content_type         :string(255)
#  avatar_file_size            :integer
#  avatar_updated_at           :datetime
#  role                        :integer          default(0)
#  group_id                    :integer
#  biography                   :text(65535)
#

class User < ActiveRecord::Base

  # Adds a enum data type which maps to integers in the users Table
  # Eventhough enum is simple to use, there are some weird
  # behaviours when querying.
  # For more, see  https://hackhands.com/ruby-on-enums-queries-and-rails-4-1/

  # Student maps to 0 in the users table. assistant to 1 and so on
  # Use user.student! to set the user role to student
  # user.role => "student"
  # use user.admin? to check if the user is an admin

  enum role: [:student, :assistant, :teacher, :admin]

  #TODO: ESTO DEBE SALIR PORQUE VAMOS A USAR DISCOURSE U OTRO SISTEMA DE COMENTARIOS
  include TheComments::User

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  belongs_to :group
  has_many :answers , :dependent => :destroy
  has_many :pages, through: :answers
  has_many :enrollments, :dependent => :destroy
  has_many :courses, through: :enrollments
  has_many :submissions, :dependent => :destroy
  has_many :pages, through: :submissions
  has_many :primary_reviews, :class_name => "Review", :foreign_key => "user_id"
  has_many :secondary_reviews, :class_name => "Review", :foreign_key => "reviewer_id"
  has_and_belongs_to_many :sprint_badges, :dependent => :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :omniauthable,
         :omniauth_providers => [:github,:facebook]

  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create
  validates :group_id, presence: true

  has_attached_file :avatar,
                    :styles => { :profile => "128x128", :menu => "80x80", :navbar => "35x35" },
                    :url => "/system/:class/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension",
                    :default_url => (self.student ? "/alumna.png" : "profesor.png") 

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

  #vUTILITARIOS
  def full_name
    "#{name} #{lastname1} #{lastname2}".strip
  end

  def email_required?
    false
  end

  def branch
    self.group.branch if group != nil
  end

  def sprints
    self.group.sprints if group != nil
  end

  def skill_points page_type
    self.pages.where(page_type: page_type).pluck('submissions.points').map(&:to_i).sum
  end

  def badge_points sprint
    self.sprint_badges.where(sprint_id: sprint.id).joins(:badge).pluck('sum(badges.points)').first
  end

  #TODO: Legacy code, remove when grades are improved
  def self.total_score_by_course(course_id)
    User.select(:id,'courses.id as course_id','sum(answers.points) as score')
    .joins(answers: {page: {unit: :course}})
    .where('pages.page_type in (?,?) and courses.id = ? and users.role = 0','editor','questions',course_id)
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
             where p.page_type in ('editor','questions') and c.id = #{course_id} and us.role = 0 and us.id = #{self.id}
             order by a.user_id, p.page_type)tb2 on tb2.page_id = p.id
             where p.page_type in ('editor','questions') and c.id = #{course_id}"

    ActiveRecord::Base.connection.execute(query)
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

    questionsAnswers
  end

  # Import data from manual grading system
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

  def self.import_score(file, lesson_id)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    lesson = Lesson.find(lesson_id)
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      user = User.where(code: row[0]).first
      if user != nil
        exercise_index = 0
        solution_index = 0
        header.each_with_index do |h,index|
          if h != "code"
            h = "prework" if h == "quiz"
            if h == "exercise"
              page = lesson.pages.where(page_type: h).order(:sequence)[exercise_index]
              exercise_index += 1
            elsif h == "solution"
              page = lesson.pages.where(page_type: h).order(:sequence)[solution_index]
              solution_index += 1
            else
              page = lesson.pages.where(page_type: h).first
            end
            subm = Submission.where(page_id: page.id, user_id: user.id)
            if subm.count == 0
              subm = Submission.new(page_id: page.id, user_id: user.id, points: row[index].to_f.round(2))
            else
              subm = subm.first
              subm.points = row[index].to_f.round
            end
            if subm.save
              p "User #{user.code} saved with grade #{row[index].to_f.round(2)}"
            else
              p "User #{user.code} failed"
            end
          end
        end
      else
        p "User #{row[0]} no existe"
      end
    end
  end

  def self.import_soft_skills_scores(file, sprint_id)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    sprint = Sprint.find(sprint_id)
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      user = User.where(code: row[0]).first
      if user != nil
        header.each_with_index do |h,index|
          if h != "code"
            soft_skill = SoftSkill.find_by_name(h)
            if soft_skill != nil
              subm = SoftSkillSubmission.where(user_id: user.id, sprint_id: sprint.id, soft_skill_id: soft_skill.id)
              if subm.count == 0
                subm = SoftSkillSubmission.new(user_id: user.id, sprint_id: sprint.id, soft_skill_id: soft_skill.id, points: row[index].to_f.round)
              else
                subm = subm.first
                subm.points = row[index].to_f.round
              end
              if subm.save
                p "User #{user.code} saved soft skill #{soft_skill.name} with grade #{row[index].to_f.round}"
              else
                p "User #{user.code} failed"
              end
            else
              p "Soft skill ingresado en el header no existe"
            end
          end
        end
      else
        p "User #{row[0]} no existe"
      end           
    end
  end

  def self.import_sprint_scores(file)
    spreadsheet = Roo::Spreadsheet.open(file)
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      user = User.where(code: row[0]).first
      if user != nil
        sprint_id = row[1]
        total_technical_skills = row[2].to_f.round(2)
        total_soft_skills = row[3].to_f.round(2)
        max_technical_skills = row[4].to_f.round(2)
        max_soft_skills = row[5].to_f.round(2)
        user_sprint = SprintSummary.where(user_id: user.id, sprint_id: sprint_id)
        if user_sprint.count > 0
          user_sprint = user_sprint.first
          user_sprint.total_technical_skills = total_technical_skills
          user_sprint.total_soft_skills = total_soft_skills
          user_sprint.max_technical_skills = max_technical_skills
          user_sprint.max_soft_skills = max_soft_skills
        else
          user_sprint = SprintSummary.new(user_id: user.id, sprint_id: sprint_id, total_technical_skills: total_technical_skills,
            total_soft_skills: total_soft_skills, max_technical_skills: max_technical_skills, max_soft_skills: max_soft_skills)
        end
        if user_sprint.save
          puts "#{user.code} saved!"
        else
          puts "Error with user #{user.code}"
        end
      else
        puts "#{row[0]} is not a user!"
      end
    end
  end

end
