# coding: utf-8
require "./commonValue.rb"

#今日の日付を取得
d = Date.today
today = format("%02d", d.month) + format("%02d", d.day)

output = "今日は\n"

#DBアクセス
db = ManagementDB.new
data = db.selectDataBirthDay(today)
for row in data do
  output = output + "・" + row["name"].force_encoding("UTF-8") + "さん\n"
end
output = output + "のお誕生日です"

response = HTTP.post($post_url, params: {
    token: $token,
    channel: $channel,
    text: output,
    as_user: true,
  })
#puts JSON.pretty_generate(JSON.parse(response.body))


