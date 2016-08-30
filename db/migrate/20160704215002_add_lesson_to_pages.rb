class AddLessonToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :lesson, index: true, foreign_key: true
  end
end
