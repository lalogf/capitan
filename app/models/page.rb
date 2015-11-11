# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  unit_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  page_type       :string(255)
#  sequence        :integer
#  instructions    :text(65535)
#  html            :text(65535)
#  initial_state   :text(65535)
#  solution        :text(65535)
#  success_message :string(255)
#

class Page < ActiveRecord::Base
  
  belongs_to :unit
  has_and_belongs_to_many :videos
  has_many :answers
  has_many :users, through: :answers
  has_many :question_groups
  has_many :questions, through: :question_groups
  
  accepts_nested_attributes_for :question_groups, 
                                 reject_if: proc { |attributes| attributes['sequence'].blank? }, 
                                 allow_destroy: true
  
  accepts_nested_attributes_for :answers

  def getCurrentQuestionGroupId(current_user)
    if (self.answers.where(:user_id => current_user.id).first.result == nil)
      return self.question_groups.first.id
    else
      answer_result = self.answers.where(:user_id => current_user.id).first.result
      s_result = answer_result.split(";")
      return s_result[0]
    end
  end
  
  def getCurrentSequence
    return self.question_groups.find(self.getCurrentQuestionGroupId).sequence if self.getCurrentQuestionGroupId != "MAX"
  end
  
end
