require 'sqlite3'

db = SQLite3::Database.new 'birthday.db'

# create table
sql = <<-SQL
  create table birthday (
    id integer primary key,
    name text,
    option text,
    birthday text,
    priority integer
  );
SQL

db.execute(sql)
