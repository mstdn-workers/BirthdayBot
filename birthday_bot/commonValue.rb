cur_path = File.expand_path(File.dirname($0))
require "http"
require "json"
require "date"
require "eventmachine"
require "faye/websocket"
require "#{cur_path}/ManagementDB.rb"

$token = ENV["SLACK_TOKEN"]
#$channel = "C5DCBBE6L"  ##create_bot
$channel = ENV["SLACK_CHANNEL"]   ##デイリー投稿先チャンネル
$server_url = ENV["SLACK_SERVER"]   ##対象ワークスペース
$post_url = "https://" + $server_url + "/api/chat.postMessage"
$rtm_url = "https://" + $server_url + "/api/rtm.start"
$help_url = "https://github.com/rinSouma/BirthdayBot/blob/master/readme.md"

$command   = "birthday"
$ins       = "birthday ins"
$upd       = "birthday upd"
$del       = "birthday del"
$show      = "birthday show"
$show_name = "birthday show name"
$show_opt  = "birthday show option"
$show_id   = "birthday show id"
$help      = "birthday help"

$search_max = 20

$def_option = ""
$def_priority = "10"

$type_ins  = "insert"
$type_del  = "delete"



