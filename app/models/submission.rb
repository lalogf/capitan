# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  user_id    :integer
#  link       :string(255)
#  points     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ActiveRecord::Base

  belongs_to :user
  belongs_to :page
    
end
