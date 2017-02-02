post "/challenge-updates" do
  content_type :json

  unless from_github?
    halt(500, { message: "Signatures didn't match!" }.to_json)
  end

  unless merged_pull_request? && for_a_challenge?
    halt(422, { message: "Not for a merged pull request for a challenge repository." }.to_json)
  end

  { message: "Thanks, GitHub.  Payload received." }.to_json
end
