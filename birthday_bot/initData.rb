# coding: utf-8
require 'csv'
require "./commonValue.rb"
require './ManagementDB.rb'
require "./commonMethod.rb"

db = ManagementDB.new
CSV.foreach('./birthday_init.csv', headers: true, encoding: "SJIS:UTF-8") do |fg|
  name = fg['name'].to_s
  option = fg['option'].to_s
  birthday = fg['birthday'].to_s

  if !checkText(name) then
    next
  end

  if !checkText(option) then
    next
  end

  if !checkDate(birthday) then
    next
  end

  date = editDate(birthday)

  data = db.insertData(name, date, option: option)
end

