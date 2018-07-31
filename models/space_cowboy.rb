require 'pg'
require 'pry'
class SpaceCowboy

  attr_accessor :name, :species, :bounty_value, :homeworld

  def initialize(options)
    @id = options['id'] if options ['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i()
    @homeworld = options['homeworld']
  end

  def save()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "INSERT INTO space_cowboys (name, species, bounty_value, homeworld)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values =[@name, @species, @bounty_value, @homeworld]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    @id = result[0]['id'].to_i()
    db.close()
  end

  def update()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "UPDATE space_cowboys SET (name, species, bounty_value, homeworld)
    = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @bounty_value, @homeworld, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def SpaceCowboy.delete_all()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM space_cowboys"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM space_cowboys WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def SpaceCowboy.find_by_name(name)
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM space_cowboys WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", values)
    db.close()
    result.count == 0 ? nil : SpaceCowboy.new(result[0])
  end

  def SpaceCowboy.find_by_id(id)
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM space_cowboys WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", values)
    db.close()
    result.count == 0 ? nil : SpaceCowboy.new(result[0])
  end

end
