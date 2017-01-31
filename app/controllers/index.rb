post "/challenge-updates" do
  content_type :json

  unless from_github?
    return halt(500, { message: "Signatures didn't match!" }.to_json)
  end

  { message: "Thanks, GitHub.  Payload received." }.to_json
end
