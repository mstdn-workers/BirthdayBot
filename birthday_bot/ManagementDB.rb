require 'sqlite3'
class ManagementDB
  def initialize
    @db = SQLite3::Database.new 'birthday.db'
  end

  #�f�[�^�o�^
  def insertData(name, birthday, priority=10)
    @db.execute('insert into birthday (name,birthday,priority) values (?,?,?)', name, birthday, priority)
  end

  #�f�[�^�X�V
  def updateData(id, name, birthday, priority=10)
    @db.execute('update birthday set name=?, birthday=?, priority=?', name, birthday, priority)
  end

  #�f�[�^�폜
  def deleteData(id)
    @db.execute('delete from birthday where id=?', id)
  end

  def selectData(sql, data)
    list = Array.new()
    @db.results_as_hash = true
    @db.execute(sql, data) do |row|
      list.push(row)
    end
    return list
  end

  #�f�[�^����
  def selectDataId(id)
    sql = 'select * from birthday where id=? order by priority, id'
    return selectData(sql, id)
  end

  #�f�[�^����
  def selectDataName(name)
    like = '%' + name + '%'
    sql = 'select * from birthday where name like ? order by priority, id'
    return selectData(sql, like)
  end

  #�f�[�^����
  def selectDataBirthDay(birthday)
    sql = 'select * from birthday where birthday=? order by priority, id'
    return selectData(sql, birthday)
  end
end
