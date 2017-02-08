# == Schema Information
#
# Table name: question_groups
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  question_id :integer
#  sequence    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuestionGroup < ActiveRecord::Base
  belongs_to :page
  belongs_to :question
  validates_numericality_of :sequence, :only_integer => true, :greater_than_or_equal_to => 0
end
