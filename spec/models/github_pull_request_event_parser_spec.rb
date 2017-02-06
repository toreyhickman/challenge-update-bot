require_relative "../spec_helper"

describe Github::PullRequestEventParser do
  describe "parsing a github request payload into a Github::PullRequesEvent" do
    let(:payload) do
      JSON.parse(File.read(APP_ROOT.to_path + "/spec/fixtures/merge_challenge_pull_request_payload.json"))
    end

    it "returns an object with an action" do
      parsed_pull_request_event = Github::PullRequestEventParser.parse(payload)
      expect(parsed_pull_request_event.action).to eq "closed"
    end

    it "returns an object with a merge status" do
      parsed_pull_request_event = Github::PullRequestEventParser.parse(payload)
      expect(parsed_pull_request_event.merge_status).to eq true
    end

    it "returns an object with a repo name" do
      parsed_pull_request_event = Github::PullRequestEventParser.parse(payload)
      expect(parsed_pull_request_event.repo_name).to eq "webhook-test-challenge"
    end
  end
end
