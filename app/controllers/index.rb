post "/challenge-updates" do
  content_type :json

  github_request = Github::RequestParser.parse(request)

  unless Github::RequestAuthenticator.valid_signature?(github_request)
    halt(404)
  end

  event = Github::PullRequestEventParser.parse(github_request.payload)
  unless event.merged_pull_request? && event.for_a_challenge?
    halt(422, { message: "Not a merged pull request for a challenge repository." }.to_json)
  end

  slack_message_details = Slack::MessageParser.parse_github_pull_request_event(event, "#curriculum", "A challenge was updated!")

  begin
    client = Slack::Web::Client.new
    client.chat_postMessage(slack_message_details)
  rescue
    halt(500, "Something went wrong when sending the message to Slack.")
  end

  { message: "Thanks, GitHub." }.to_json
end

