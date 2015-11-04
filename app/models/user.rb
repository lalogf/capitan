# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  admin                  :boolean          default(FALSE)
#  dni                    :string(255)      not null
#  code                   :string(255)
#  name                   :string(255)      not null
#  lastname1              :string(255)      not null
#  lastname2              :string(255)      not null
#  age                    :integer          not null
#  district               :string(255)      not null
#  facebook_username      :string(255)
#  phone1                 :string(255)      not null
#  phone2                 :string(255)
#  branch_id              :integer
#

class User < ActiveRecord::Base
  
  after_create :generate_code  
  
  
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  belongs_to :branch
  has_many :answers
  has_many :pages, through: :answers
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable, 
         :omniauthable, 
         :omniauth_providers => [:github,:facebook]
  
  
  def self.create_from_omniauth(params)
    attributes = {
      name: params['info']['name'],
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end
  
protected

  def generate_code
    self.code = self.branch.code + self.id.to_s
    self.save
  end  


end
