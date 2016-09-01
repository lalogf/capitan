# == Schema Information
#
# Table name: sprints
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  group_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sprint < ActiveRecord::Base
  has_and_belongs_to_many :lessons
  belongs_to :group

  validates :group_id, presence: true
end
