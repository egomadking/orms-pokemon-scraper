require "pry"

class Pokemon

  attr_accessor :name, :type, :db
  attr_reader :id


  def initialize(row)
    @name = row[:name]
    @type = row[:type]
    @id = row[:id]
    @db = row[:db]
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT id, name, type FROM pokemon
      WHERE id = ?
    SQL
    monster = db.execute(sql, id)[0]
    # binding.pry
    self.new(:name => monster[1], :id => monster[0], :type => monster[2])
  end
end
