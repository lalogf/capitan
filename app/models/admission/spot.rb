# == Schema Information
#
# Table name: spots
#
#  id         :integer          not null, primary key
#  branch_id  :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :boolean
#

class Spot < ActiveRecord::Base
  belongs_to :branch

  def self.by_branch branch_id
    !branch_id.nil? ? self.where(branch_id: branch_id, status: true) : []
  end

end
