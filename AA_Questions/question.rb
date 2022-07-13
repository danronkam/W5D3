require_relative 'QuestionsDatabase.rb'
require_relative 'user.rb'
require_relative 'Reply.rb'

class Question
attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    data = QuestionsDatabase.execute(<<-SQL)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = id
    SQL

    Question.new(data.first)
  end

  def self.find_by_author_id(author_id)
    raw_data = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      WHERE 
        questions.author_id = author_id
    SQL

    raw_data.map {|data| Question.new(data)}
  end

  def initialize(object)
    @id = object[:id]
    @title = object[:title]
    @body = object[:body]
    @author_id = object[:author_id]
  end


end