# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sequence    :integer          default(0)
#

module UnitsHelper
end
