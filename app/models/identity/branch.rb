# == Schema Information
#
# Table name: branches
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string(255)
#  address    :string(255)
#

class Branch < ActiveRecord::Base
    has_many :groups
    has_many :users, through: :groups
    has_many :pages, through: :page_visibilities
    has_many :page_visibilities

    def students
      self.users.where(role: 1, disable: 0)
    end

    def admins
      self.users.where.not(role: [0,1]).where(disable: 0)
    end

    def students_and_admins
      self.students.where(role:[1,2,3,4],disable: 0)
    end

    def disables
      self.users.where(disable: 1)
    end
end
