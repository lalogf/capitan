# == Schema Information
#
# Table name: options
#
#  id          :integer          not null, primary key
#  description :string(255)
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  correct     :boolean
#

class Option < ActiveRecord::Base
  belongs_to :question
  validates :description, presence: true
end
