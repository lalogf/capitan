class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :pages, :dependent => :destroy
  
  def visible_pages_by_type(branch_id,page_type)
    self.visible_pages(branch_id).where(page_type: page_type).order(:sequence)
  end
  
  def visible_pages(branch_id)
    return self.pages.visible_page(branch_id).order(:sequence)
  end
  
  def total_points
    return self.pages.sum(:points)
  end
    
end
