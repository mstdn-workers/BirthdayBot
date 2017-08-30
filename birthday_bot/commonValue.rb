cur_path = File.expand_path(File.dirname($0))
require "http"
require "json"
require "date"
require "eventmachine"
require "faye/websocket"
require "#{cur_path}/ManagementDB.rb"

$token = ENV["SLACK_TOKEN"]
#$channel = "C5DCBBE6L"  ##create_bot
$channel = "C6VFTMXM5"   ##íaê∂ì˙
$server_url = "mstdn-workers.slack.com"
$post_url = "https://" + $server_url + "/api/chat.postMessage"
$rtm_url = "https://" + $server_url + "/api/rtm.start"

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



