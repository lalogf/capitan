class DropCommentsGemColumns < ActiveRecord::Migration
  def change
    remove_column :pages, :draft_comments_count
    remove_column :pages, :published_comments_count
    remove_column :pages, :deleted_comments_count

    remove_column :users, :my_draft_comments_count
    remove_column :users, :my_published_comments_count
    remove_column :users, :my_comments_count
    remove_column :users, :draft_comcoms_count
    remove_column :users, :published_comcoms_count
    remove_column :users, :deleted_comcoms_count
    remove_column :users, :spam_comcoms_count
    remove_column :users, :roles_mask
  end
end
