require_relative "../spec_helper"

describe Slack::MessageParser do
  describe "parsing a Github::PullRequestEvent" do
    it "organizes the pull request data into message details for the Slack API" do
      pull_request_event = double("event", {
        :repo_name => "webhook-test-challenge",
        :title     => "Explains expected responses",
        :url       => "https://github.com/devbootcamp-curriculum/webhook-test-repo/pull/2"
      })

      expected_payload = {
        :channel     => "#channel",
        :as_user     => true,
        :attachments => [{
          :title   => "webhook-test-challenge",
          :pretext => "Something happened!",
          :text    => "Explains expected responses\nhttps://github.com/devbootcamp-curriculum/webhook-test-repo/pull/2"
        }]
      }

      actual_payload = Slack::MessageParser.parse_github_pull_request_event(pull_request_event, "#channel", "Something happened!")

      expect(actual_payload).to eq expected_payload
    end
  end
end
