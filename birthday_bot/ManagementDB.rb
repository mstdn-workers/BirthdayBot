require 'sqlite3'
class ManagementDB
  def initialize
    cur_path = File.expand_path(File.dirname($0))
    @db = SQLite3::Database.new "#{cur_path}/birthday.db"
  end

  #データ登録
  def insertData(name, birthday, option: "", priority: 10)
    @db.execute('insert into birthday (name,option,birthday,priority) values (?,?,?,?)', name, option, birthday, priority)
    return selectDataId(@db.last_insert_row_id)
  end

  #データ更新
  def updateData(id, name, birthday, option: "", priority: 10)
    @db.execute('update birthday set name=?, option=?, birthday=?, priority=? where id=?', name, option, birthday, priority, id)
    return selectDataId(id)
  end

  #データ削除
  def deleteData(id)
    data = selectDataId(id)
    @db.execute('delete from birthday where id=?', id)
    return data
  end

  #データ検索
  def selectData(sql, data)
p sql
p data
    list = Array.new()
    @db.results_as_hash = true
    @db.execute(sql, data) do |row|
      list.push(row)
    end
    return list
  end

  #データ検索
  def selectDataId(id)
    sql = 'select * from birthday where id=? order by priority, id'
    return selectData(sql, id)
  end

  #データ検索
  def selectDataName(name, month: "")
    like = '%' + name + '%'
    if month == "" then
      sql = 'select * from birthday where name like ? order by birthday, priority, id'
      return selectData(sql, like)
    else
      mStr = month + "01"
      mEnd = month + "31"
      where = [like, mStr, mEnd]
      sql = 'select * from birthday where name like ? and birthday between ? and ? order by birthday, priority, id'
      return selectData(sql, where)
    end
  end

  #データ検索
  def selectDataOption(option, month: "")
    like = '%' + option + '%'
    if month == "" then
      sql = 'select * from birthday where option like ? order by birthday, priority, id'
      return selectData(sql, like)
    else
      mStr = month + "01"
      mEnd = month + "31"
      where = [like, mStr, mEnd]
      sql = 'select * from birthday where option like ? and birthday between ? and ? order by birthday, priority, id'
      return selectData(sql, where)
    end
  end

  #データ検索
  def selectDataBirthDay(birthday)
    sql = 'select * from birthday where birthday=? order by priority, id'
    return selectData(sql, birthday)
  end

  #データ存在チェック
  def checkDataExist(name, option, birthday)
    sql = 'select count(id) as count from birthday where name=? and option=? and birthday=?'
    @db.results_as_hash = true
    @db.execute(sql, name, option, birthday) do |row|
      if row['count'].to_i >= 1 then
        return true
      else
        return false
      end
    end
  end
end
