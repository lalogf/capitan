class ChangeProfileFacebookLinkToText < ActiveRecord::Migration
  def change
    change_column :profiles, :facebook_link, :text
  end
end
