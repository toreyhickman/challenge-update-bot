post "/challenge-updates" do
  content_type :json

  unless from_github?
    return halt(500, { message: "Signatures didn't match!" }.to_json)
  end

  unless merged_pull_request?
    return halt(422, { message: "Not for a merged pull request" }.to_json)
  end

  { message: "Thanks, GitHub.  Payload received." }.to_json
end
