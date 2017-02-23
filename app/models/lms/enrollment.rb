# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :boolean
#  track_id   :integer
#

class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  scope :active, -> { where(status: 1) }
end
