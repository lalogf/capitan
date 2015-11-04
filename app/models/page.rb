# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  unit_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  page_type    :string(255)
#  sequence     :integer
#  instructions :string(255)
#

class Page < ActiveRecord::Base
  
  belongs_to :unit
  has_and_belongs_to_many :videos
  has_many :answers
  has_many :users, through: :answers
  
  accepts_nested_attributes_for :answers
  
end
