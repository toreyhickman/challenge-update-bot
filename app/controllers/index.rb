post "/curriculum-updates" do
  content_type :json

  github_request = Github::RequestParser.parse(request)

  unless Github::RequestAuthenticator.valid_signature?(github_request)
    halt(404)
  end

  event = Github::PullRequestEventParser.parse(github_request.payload)
  unless announceable?(event)
    halt(422, { message: "Not a merged pull request to master for a challenge or phase guide." }.to_json)
  end

  client = Slack::ClientBuilder.build_client(event)
  slack_message_details = Slack::MessageParser.parse_github_pull_request_event(event, ENV["SLACK_CHANNEL"])

  begin
    client.chat_postMessage(slack_message_details)
  rescue
    halt(500, "Something went wrong when sending the message to Slack.")
  end

  { message: "Thanks, GitHub." }.to_json
end

