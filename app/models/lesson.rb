class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :pages, :dependent => :destroy
  
  def has_visible_pages_by_type(branch_id, page_type)
    return self.visible_pages_by_type(branch_id, page_type).count > 0
  end
  
  def visible_pages_by_type(branch_id,page_type)
    self.visible_pages(branch_id).where(page_type: page_type).order(:sequence)
  end
  
  def visible_pages(branch_id)
    return self.pages.visible_page(branch_id).order(:sequence)
  end
  
  def total_points
    return self.pages.sum(:points)
  end
  
  def total_points_by_type(page_type)
    return self.pages.where(page_type: page_type).sum(:points)
  end
    
end
