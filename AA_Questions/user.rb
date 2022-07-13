require_relative 'question'
# require_relative 'QuestionDatabase'
# # require_relative 'Reply.rb'

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionsDatabase.get_first_value(<<-SQL)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = id
    SQL

    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.get_first_value(<<-SQL)
    SELECT
      *
    FROM
      users
    WHERE
      users.fname = fname AND
      users.lname = lname
    SQL

    User.new(data.first)
  end

  def initialize(object)
    @id = object[:id]
    @fname = object[:fname]
    @lname = object[:lname]
  end

  def authored_questions #should return an Array of Question Objects
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end
  
end
