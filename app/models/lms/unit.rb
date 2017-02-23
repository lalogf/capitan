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
#  points      :integer
#  duration    :integer
#

class Unit < ActiveRecord::Base

  belongs_to :course
  has_many :lessons, :dependent => :destroy

  def has_pages(branch_id)
    query = "select count(p.id)
             from pages p
             join lessons l on p.lesson_id = l.id
             join units u on l.unit_id = u.id
             join page_visibilities pv on p.id = pv.page_id
             where u.id = #{self.id} and branch_id = #{branch_id} and pv.status = 1"
    ActiveRecord::Base.connection.execute(query).first[0] > 0
  end

  # def visible_pages(branch_id)
  #   return self.lessons.visible_page(branch_id).order(:sequence)
  # end

  def total_points
    self.lessons.sum(:points)
  end

end
