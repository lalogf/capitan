class Group < ActiveRecord::Base
  belongs_to :branch
  has_many :users
end
