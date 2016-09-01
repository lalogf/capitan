# == Schema Information
#
# Table name: badges
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Badge < ActiveRecord::Base

  validates :name, presence: true
  validates :image, presence: true

  has_attached_file :image,
                    :styles => { :normal => "75x75" },
                    :url => "/system/:class/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
