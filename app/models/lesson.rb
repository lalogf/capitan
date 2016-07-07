class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :pages, :dependent => :destroy
  
  def visible_pages(branch_id)
    return self.pages.visible_page(branch_id).order(:sequence)
  end
  
  def total_points
    return self.pages.sum(:points)
  end
    
end
