# == Schema Information
#
# Table name: videos
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  content_updated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Video < ActiveRecord::Base

 has_and_belongs_to_many :pages
    
 validates :content, presence: true    
 
 has_attached_file :content 
    
 validates_attachment_content_type :content, :content_type => /\Avideo\/.*\Z/  
 validates_attachment_file_name :content, :matches => [/3gp\Z/, /mp4\Z/, /flv\Z/]
    
end
