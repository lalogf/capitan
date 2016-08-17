# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  email                       :string(255)      default("")
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  provider                    :string(255)
#  uid                         :string(255)
#  role                        :integer          default(0)
#  dni                         :string(255)
#  code                        :string(255)
#  name                        :string(255)      not null
#  lastname1                   :string(255)      not null
#  lastname2                   :string(255)
#  age                         :integer
#  district                    :string(255)
#  facebook_username           :string(255)
#  phone1                      :string(255)
#  phone2                      :string(255)
#  branch_id                   :integer
#  disable                     :boolean          default(FALSE)
#  my_draft_comments_count     :integer          default(0)
#  my_published_comments_count :integer          default(0)
#  my_comments_count           :integer          default(0)
#  draft_comcoms_count         :integer          default(0)
#  published_comcoms_count     :integer          default(0)
#  deleted_comcoms_count       :integer          default(0)
#  spam_comcoms_count          :integer          default(0)
#  roles_mask                  :integer
#

module UsersHelper
end
