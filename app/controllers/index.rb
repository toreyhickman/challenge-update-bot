post "/challenge-updates" do
  content_type :json

  github_request = Github::RequestParser.parse(request)

  authenticator = Github::RequestAuthenticator.new
  unless authenticator.valid_signature?(github_request)
    halt(500, { message: "Signatures didn't match!" }.to_json)
  end

  event = Github::PullRequestEventParser.parse(github_request.payload)
  unless event.merged_pull_request? && event.for_a_challenge?
    halt(422, { message: "Not a merged pull request for a challenge repository." }.to_json)
  end

  { message: "Thanks, GitHub.  Payload received." }.to_json
end
