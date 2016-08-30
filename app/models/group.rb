class Group < ActiveRecord::Base
  belongs_to :branch
  has_many :users
  has_many :sprints

  def students
    self.users.where(role: 0, disable: 0)
  end

  def admins
    self.users.where.not(role: 0).where(disable: 0)
  end

  def disables
    self.users.where(disable: 1)
  end

end
