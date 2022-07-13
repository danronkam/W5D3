class QuestionFollow
  attr_accessor :id, :question_id, :user_id
  
  def self.find_by_id(id)
    data = QuestionsDatabase.execute(<<-SQL)
    SELECT
      *
    FROM
      question_follows
    WHERE
      question_follows.id = id
    SQL

    QuestionFollow.new(data.first)
  end

  def initialize(object)
    @id = object[:id]
    @question_id = object[:question_id]
    @user_id = object[:user_id]

  end
end