# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  unit_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sequence    :integer          default(0)
#  points      :integer
#  lesson_plan :string(255)
#

class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :pages, :dependent => :destroy

  def has_visible_pages_by_type(branch_id, page_type)
    self.visible_pages_by_type(branch_id, page_type).count > 0
  end

  def visible_pages_by_type(branch_id,page_type)
    self.visible_pages(branch_id).where(page_type: page_type).order(:sequence)
  end

  def visible_pages(branch_id)
    self.pages.visible_page(branch_id).order(:sequence)
  end

  def total_points
    self.pages.sum(:points)
  end

  def total_points_by_type(page_type)
    self.pages.where(page_type: page_type).sum(:points)
  end

end
