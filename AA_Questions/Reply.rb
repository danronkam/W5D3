require_relative 'user.rb'
require_relative 'question.rb'
require_relative 'QuestionsDatabase'
require 'byebug'

class Reply
  attr_accessor :id, :subject_question, :parent_reply_id, :author_id, :body

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = :id
    SQL

    Reply.new(data.first)
  end

  def self.find_by_user_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.author_id = :id
    SQL

    data.map {|obj| Reply.new(obj)}
  end

  def self.find_by_question_id(id)
    # debugger
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.subject_question = :id
    SQL

    data.map {|obj| Reply.new(obj)}
  end
  
  def initialize(object)
    @id = object['id']
    @subject_question = object['subject_question']
    @parent_reply_id = object['parent_reply_id']
    @author_id = object['author_id']
    @body = object['body']
  end


  def author
    User.find_by_id(self.author_id)
  end

  def question
    Question.find_by_id(self.subject_question)
  end

  
end