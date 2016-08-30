# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :page
  has_many :options, dependent: :destroy 
  has_many :question_groups,dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :description, presence: true
  
  accepts_nested_attributes_for :options, 
                                 reject_if: proc { |attributes| attributes['description'].blank? }, 
                                 allow_destroy: true  
  
end
