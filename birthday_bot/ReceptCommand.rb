# coding: utf-8
cur_path = File.expand_path(File.dirname($0))
require "#{cur_path}/commonValue.rb"
require "#{cur_path}/RunCommand.rb"

rc = RunCommand.new

response = HTTP.post($rtm_url, params: {
  token: $token
})
res = JSON.parse(response.body)
url = res['url']

EM.run do
  # Web Socketインスタンスの立ち上げ
  ws = Faye::WebSocket::Client.new(url)

  #  接続が確立した時の処理
  ws.on :open do
    p [:open]
  end

  # RTM APIから情報を受け取った時の処理
  ws.on :message do |event|
    data = JSON.parse(event.data)
    #p [:message, data] 
    if data['text'].nil? then
      next
    end

    if data['text'].index($command) == 0 then
      output = rc.analysisCmd(data['text'])
      ws.send({
        type: "message",
        text: output,
        channel: data['channel'],
      }.to_json)
    end
  end

  # 接続が切断した時の処理
  ws.on :close do
    p [:close]
    ws = nil
    EM.stop
  end
end
