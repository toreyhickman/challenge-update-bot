require "slack_ruby_client"

Slack.configure do |config|
  config.token = ENV["SLACK_API_TOKEN"]
end
