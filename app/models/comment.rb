# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  holder_id         :integer
#  commentable_id    :integer
#  commentable_type  :string(255)
#  commentable_url   :string(255)
#  commentable_title :string(255)
#  commentable_state :string(255)
#  anchor            :string(255)
#  title             :string(255)
#  contacts          :string(255)
#  raw_content       :text(65535)
#  content           :text(65535)
#  view_token        :string(255)
#  state             :string(255)      default("draft")
#  ip                :string(255)      default("undefined")
#  referer           :string(255)      default("undefined")
#  user_agent        :string(255)      default("undefined")
#  tolerance_time    :integer
#  spam              :boolean          default(FALSE)
#  parent_id         :integer
#  lft               :integer
#  rgt               :integer
#  depth             :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  include TheComments::Comment
  # ---------------------------------------------------
  # Define comment's avatar url
  # Usually we use Comment#user (owner of comment) to define avatar
  # @blog.comments.includes(:user) <= use includes(:user) to decrease queries count
  # comment#user.avatar_url
  # ---------------------------------------------------

  # public
  # ---------------------------------------------------
  # Simple way to define avatar url
  #
  # def avatar_url
  #   src = id.to_s
  #   src = title unless title.blank?
  #   src = contacts if !contacts.blank? && /@/ =~ contacts
  #   hash = Digest::MD5.hexdigest(src)
  #   "https://2.gravatar.com/avatar/#{hash}?s=42&d=https://identicons.github.com/#{hash}.png"
  # end
  # ---------------------------------------------------

  # private
  # ---------------------------------------------------
  # Define your content filters
  # gem 'RedCloth'
  # gem 'sanitize'
  # gem 'MySmilesProcessor'
  #
  # def prepare_content
  #   text = self.raw_content
  #   text = RedCloth.new(text).to_html
  #   text = MySmilesProcessor.new(text)
  #   text = Sanitize.clean(text, Sanitize::Config::RELAXED)
  #   self.content = text
  # end
  # ---------------------------------------------------
end
