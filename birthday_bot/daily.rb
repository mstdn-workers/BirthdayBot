# coding: utf-8
cur_path = File.expand_path(File.dirname($0))
require "#{cur_path}/commonValue.rb"
require "#{cur_path}/commonMethod.rb"

#今日の日付を取得
d = Date.today
today = format("%02d", d.month) + format("%02d", d.day)

output = "今日は\n"
#DBアクセス
db = ManagementDB.new
data = db.selectDataBirthDay(today)
i = 0
for row in data do
  name = row["name"].force_encoding("UTF-8")
  option = row["option"].force_encoding("UTF-8")
  output = output + "・" + editViewName(name, option) + "\n"
i += 1
end
if i <= 0 then
  output = "今日がお誕生日の人は登録されていません"
else
  output = output + "のお誕生日です"
end

response = HTTP.post($post_url, params: {
    token: $token,
    channel: $channel,
    text: output,
    as_user: true,
  })
#puts JSON.pretty_generate(JSON.parse(response.body))


