require "http"
require "json"
require "date"
require "./ManagementDB.rb"

$token = ENV["SLACK_TOKEN"]
$channel = "#create_bot"
$post_url = "https://mstdn-workers.slack.com/api/chat.postMessage"
