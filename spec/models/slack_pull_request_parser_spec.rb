require_relative "../spec_helper"

describe SlackPullRequestParser do
  it "parses a GitHub::PullRequestEvent into details for Slack" do
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
        :pretext => "A challenge was updated!",
        :text    => "Explains expected responses\nhttps://github.com/devbootcamp-curriculum/webhook-test-repo/pull/2"
      }]
    }

    actual_payload = SlackPullRequestParser.parse(pull_request_event, "#channel", "A challenge was updated!")

    expect(actual_payload).to eq expected_payload
  end
end
