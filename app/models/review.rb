class Review < ActiveRecord::Base
  belongs_to :page
  belongs_to :question
  belongs_to :user, :class_name => "User"
  belongs_to :reviewer, :class_name => "User"
  
  
  def self.import(file, lesson_id)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    header.each do |desc|
      question = Question.where(description: desc)
      if question.exists?
        p "Existe -> #{desc}"
      else
        q = Question.new(description: desc)
        if q.save
          p "Creado -> #{desc}"
        else
          p "Error"
        end
      end
    end
    q1 = Question.where(description: header[2]).first
    q2 = Question.where(description: header[3]).first
    q3 = Question.where(description: header[4]).first
    page_id = Lesson.find(lesson_id).pages.where(page_type: "codereview").first.id
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      reviewer = User.where(code: row[0]).first
      user = User.where(code: row[1]).first
      if reviewer != nil and user != nil
        review1 = Review.new(page_id: page_id, user_id: user.id, reviewer_id: reviewer.id, question_id: q1.id, answer: row[2])
        if review1.save
          p "Guardado!"
        end
        review2 = Review.new(page_id: page_id, user_id: user.id, reviewer_id: reviewer.id, question_id: q2.id, answer: row[3])
        if review2.save
          p "Guardado"
        end
        review3 = Review.new(page_id: page_id, user_id: user.id, reviewer_id: reviewer.id, question_id: q3.id, answer: row[4])
        if review3.save
          p "Guardado"
        end
      end
    end
  end
end
