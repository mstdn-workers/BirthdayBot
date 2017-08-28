# coding: utf-8
require 'http'
require 'json'
require './ManagementDB.rb'

#response = HTTP.post("https://mstdn-workers.slack.com/api/chat.postMessage", params: {
#    token: ENV['SLACK_TOKEN'],
#    channel: "#create_bot",
#    text: "おめでとう！おめでとう！",
#    as_user: true,
#  })
#puts JSON.pretty_generate(JSON.parse(response.body))

db = ManagementDB.new
db.insertData("椿野 美幸(劔谷高校３年)",'0101',1)
#db.insertData("辻垣内 智葉(臨海女子３年・部長)",'0102')
#db.insertData("大星 淡(白糸台高校１年)",'1215')
#db.updateData(1, "辻垣内 智葉(臨海女子３年・部長)",'0102',11)
#db.deleteData(1)
data = db.selectDataId(2)
for row in data do

  puts row['id']
  puts row['name'].force_encoding("UTF-8")
  puts row['birthday']
  puts row['priority']

end
puts "---------------------------------------------------"
data = db.selectDataName('年')
for row in data do

  puts row['id']
  puts row['name'].force_encoding("UTF-8")
  puts row['birthday']
  puts row['priority']

end
puts "---------------------------------------------------"
data = db.selectDataBirthDay('0102')
for row in data do

  puts row['id']
  puts row['name'].force_encoding("UTF-8")
  puts row['birthday']
  puts row['priority']

end


