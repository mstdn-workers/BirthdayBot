# coding: utf-8
require 'http'
require 'json'
require './ManagementDB.rb'
require 'eventmachine'
require 'faye/websocket'

str = "0101"
p str
if str !~ /^\d{4}+$/
  puts "ある"
else
  puts "ない"
end
str = "123"
p str
if str !~ /^\d{4}+$/
  puts "ある"
else
  puts "ない"
end



#response = HTTP.post("https://mstdn-workers.slack.com/api/rtm.start", params: {
#    token: ENV['SLACK_TOKEN']
#  })
#
#rc = JSON.parse(response.body)
#
#url = rc['url']
#
#EM.run do
#  # Web Socketインスタンスの立ち上げ
#  ws = Faye::WebSocket::Client.new(url)
#
#  #  接続が確立した時の処理
#  ws.on :open do
#    p [:open]
#  end
#
#  # RTM APIから情報を受け取った時の処理
#  ws.on :message do |event|
#    data = JSON.parse(event.data)
#    p [:message, data] 
#
#    if data['text'] == "birthday"
#      ws.send({
#        type: "message",
#        text: "おめでとう！おめでとう！",
#        channel: data['channel'],
#      }.to_json)
#    end
#
#  end
#
#  # 接続が切断した時の処理
#  ws.on :close do
#    p [:close, event.code]
#    ws = nil
#    EM.stop
#  end
#
#end
#response = HTTP.post("https://mstdn-workers.slack.com/api/chat.postMessage", params: {
#    token: ENV['SLACK_TOKEN'],
#    channel: "#create_bot",
#    text: "おめでとう！おめでとう！",
#    as_user: true,
#  })
#puts JSON.pretty_generate(JSON.parse(response.body))

#db = ManagementDB.new
#data = db.insertData("菊地真(THE IDOLM@STER)",'0829')
#db.insertData("水橋かおり(声優)",'0828', 5)
#db.insertData("辻垣内 智葉(臨海女子３年・部長)",'0102')
#db.insertData("大星 淡(白糸台高校１年)",'1215')
#db.updateData(1, "辻垣内 智葉(臨海女子３年・部長)",'0102',11)
#db.deleteData(1)
#data = db.selectDataId(2)
#for row in data do
#
#  puts row['id']
#  puts row['name'].force_encoding("UTF-8")
#  puts row['birthday']
#  puts row['priority']
#
#end
#puts "---------------------------------------------------"
#data = db.selectDataName('声優')
#for row in data do
#
#  puts row['id']
#  puts row['name'].force_encoding("UTF-8")
#  puts row['birthday']
#  puts row['priority']
#
#end
#puts "---------------------------------------------------"
#data = db.selectDataBirthDay('0828')
#for row in data do
#
#  puts row['id']
#  puts row['name'].force_encoding("UTF-8")
#  puts row['birthday']
#  puts row['priority']
#
#end
#
#
