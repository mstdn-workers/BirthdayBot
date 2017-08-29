require "http"
require "json"
require "date"
require "eventmachine"
require "faye/websocket"
require "./ManagementDB.rb"

$token = ENV["SLACK_TOKEN"]
$channel = "#create_bot"
$server_url = "mstdn-workers.slack.com"
$post_url = "https://" + $server_url + "/api/chat.postMessage"
$rtm_url = "https://" + $server_url + "/api/rtm.start"

$command   = "birthday"
$ins       = "birthday ins"
$upd       = "birthday upd"
$del       = "birthday del"
$show      = "birthday show"
$show_name = "birthday show name"
$show_id   = "birthday show id"

$def_priority = "10"

$type_ins  = "insert"
$type_del  = "delete"