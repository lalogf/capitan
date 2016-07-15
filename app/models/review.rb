class Review < ActiveRecord::Base
  belongs_to :page
  belongs_to :question
  belongs_to :user, :class_name => "User"
  belongs_to :reviewer, :class_name => "User"
  
  
  def self.import(file)
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
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      page_id = Page.where(page_type: "codereview").first.id
      reviewer = User.where(code: row[0]).first
      user = User.where(code: row[1]).first
      if reviewer != nil and user != nil
        review = Review.new(page_id: page_id, user_id: user.id, reviewer_id: reviewer.id, question_id: q1.id, answer: row[])
      end
      Review.where(page_id: page_id)
    end
  end
end
