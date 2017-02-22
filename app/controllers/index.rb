post "/challenge-updates" do
  content_type :json

  github_request = Github::RequestParser.parse(request)

  authenticator = Github::RequestAuthenticator.new
  unless authenticator.valid_signature?(github_request)
    halt(404)
  end

  event = Github::PullRequestEventParser.parse(github_request.payload)
  unless event.merged_pull_request? && event.for_a_challenge?
    halt(422, { message: "Not a merged pull request for a challenge repository." }.to_json)
  end

  details_for_slack = SlackPullRequestParser.parse(event)

  begin
    client = Slack::Web::Client.new
    client.chat_postMessage(details_for_slack)
  rescue
    halt(500, "Something went wrong when sending the message to Slack.")
  end

  { message: "Thanks, GitHub." }.to_json
end

