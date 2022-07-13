class QuestionLike
  attr_accessor :id, :user_id, :question_id
  
  def self.find_by_id(id)
    data = QuestionsDatabase.execute(<<-SQL)
    SELECT
      *
    FROM
      question_likes
    WHERE
      question_likes.id = id
    SQL

    QuestionLike.new(data.first)
  end

  def initialize(object)
    @id = object[:id]
    @user_id = object[:user_id]
    @question_id = object[:question_id]

  end
end