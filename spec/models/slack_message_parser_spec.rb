require_relative "../spec_helper"

describe Slack::MessageParser do
  describe "parsing a Github::PullRequestEvent" do
    context "when for a challenge repo" do
      it "organizes the pull request data into message details for the Slack API" do

        pull_request_event = double("event", {
          :repo_name          => "webhook-test-challenge",
          :title              => "Explains expected responses",
          :url                => "https://github.com/devbootcamp-curriculum/webhook-test-repo/pull/2",
          :for_a_challenge?   => true,
          :for_a_phase_guide? => false
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

        actual_payload = Slack::MessageParser.parse_github_pull_request_event(pull_request_event, "#channel")

        expect(actual_payload).to eq expected_payload
      end
    end

    context "when for a phase guide repo" do
      it "organizes the pull request data into message details for the Slack API" do

        pull_request_event = double("event", {
          :repo_name          => "phase-1-guide",
          :title              => "Includes more JS",
          :url                => "https://github.com/devbootcamp-curriculum/phase-1-guide/pull/12",
          :for_a_challenge?   => false,
          :for_a_phase_guide? => true
        })

        expected_payload = {
          :channel     => "#channel",
          :as_user     => true,
          :attachments => [{
            :title   => "phase-1-guide",
            :pretext => "A phase guide was updated!",
            :text    => "Includes more JS\nhttps://github.com/devbootcamp-curriculum/phase-1-guide/pull/12"
          }]
        }

        actual_payload = Slack::MessageParser.parse_github_pull_request_event(pull_request_event, "#channel")

        expect(actual_payload).to eq expected_payload
      end
    end
  end
end
