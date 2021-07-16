  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
require 'pry'

class Student
  attr_accessor :name, :length
  attr_reader :id

  def initialize(name, length, id=nil)
    @name = name
    @length = length
    @id = id
  end
    
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY, 
        title TEXT, 
        length INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end
    
  def self.drop_table
    sql =  "DROP TABLE students"
  DB[:conn].execute(sql)      
  end

  def self.new_from_db(row)
    new_song = self.new  # self.new is the same as running Song.new
    new_song.id = row[0]
    new_song.name =  row[1]
    new_song.length = row[2]
    new_song  # return the newly created instance
  end 

  def self.create(name)
    sql = <<-SQL
      SELECT *
      FROM songs
      WHERE name = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
    binding.pry

  end

  def save
    sql =  "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # def self.create(name:, grade:)
  #   student = Student.new(name, grade)
  #   student.save
  #   student
  # end






    
    
    
    
    
end#class ender
