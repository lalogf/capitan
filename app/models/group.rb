# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  branch_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ActiveRecord::Base
  belongs_to :branch
  has_many :users
  has_many :sprints, dependent: :destroy

  def students
    self.users.where(role: 1, disable: 0)
  end

  def admins
    self.users.where.not(role: [0,1]).where(disable: 0)
  end

  def disables
    self.users.where(disable: 1)
  end

end
