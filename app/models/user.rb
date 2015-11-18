require 'roo'
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  admin                  :boolean          default(FALSE)
#  dni                    :string(255)      not null
#  code                   :string(255)
#  name                   :string(255)      not null
#  lastname1              :string(255)      not null
#  lastname2              :string(255)      not null
#  age                    :integer          not null
#  district               :string(255)      not null
#  facebook_username      :string(255)
#  phone1                 :string(255)
#  phone2                 :string(255)
#  branch_id              :integer
#

class User < ActiveRecord::Base
  
  #after_create :generate_code  
  
  
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  belongs_to :branch
  has_many :answers
  has_many :pages, through: :answers
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :omniauthable, 
         :omniauth_providers => [:github,:facebook]
  
  
  def self.create_from_omniauth(params)
    attributes = {
      name: params['info']['name'],
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end
  
  def full_name
    return "#{name} #{lastname1} #{lastname2}"
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
  
  def email_required?
    false
  end
  
  def total_points()
    points = 0
    self.answers.each do |answer|
        points = points + answer.points if ["editor","questions"].include?(answer.page.page_type) and answer.points != nil 
    end
    return points
  end
  
  def subtotal_points()
    points = 0
    self.answers.each do |answer|
      points = points + answer.points if ["editor","questions"].include?(answer.page.page_type) and !answer.page.selfLearning?
    end
    return points
  end

  def calculate_self_learning_points()
    points = 0
    self.answers.each do |answer|
      points = points + answer.points if ["questions"].include?(answer.page.page_type) and answer.page.selfLearning?
    end
    return points    
  end
  
  def calculate_test_time()
    answers = self.answers.order(:created_at)
    return !answers.empty? ? (answers.try(:last).try(:created_at) - answers.try(:first).try(:created_at)) : 0
  end
  
  def getEditorAnswers()
    self.answers.select { |answer| answer.page.page_type == "editor" }
  end
  
  def getQuestions()
    questionsAnswers = []
    self.answers.each do |answer|
      if (answer.page.page_type == "questions" and !answer.page.selfLearning)
        parts = answer.result.split(";")
        for i in 1...parts.length
          question_id_option_id = parts[i].split("|")
          questionsAnswers << [QuestionGroup.find(question_id_option_id[0]),Option.find(question_id_option_id[1]),answer]
        end
      end
    end
    return questionsAnswers
  end
  
  def getSelfLearningQuestions()
    questionsAnswers = []
    self.answers.each do |answer|
      if (answer.page.page_type == "questions" and answer.page.selfLearning)
        parts = answer.result.split(";")
        for i in 1...parts.length
          question_id_option_id = parts[i].split("|")
          questionsAnswers << [QuestionGroup.find(question_id_option_id[0]),Option.find(question_id_option_id[1]),answer]
        end
      end
    end
    return questionsAnswers
  end  

end