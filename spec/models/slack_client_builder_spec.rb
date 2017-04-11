require_relative "../spec_helper"

describe Slack::ClientBuilder do
  context "when building a client to announce a challenge update" do
    it "builds a client with the challenge update bot's token" do
      pull_request_event = double("event", { :for_a_challenge? => true, :for_a_phase_guide? => false })
      client = Slack::ClientBuilder.build_client(pull_request_event)

      expect(client.token).to eq ENV["SLACK_CHALLENGE_UPDATE_BOT_TOKEN"]
    end
  end

  context "when building a client to announce a phase guide update" do
    it "builds a client with the phase guide update bot's token" do
      pull_request_event = double("event", { :for_a_challenge? => false, :for_a_phase_guide? => true })
      client = Slack::ClientBuilder.build_client(pull_request_event)

      expect(client.token).to eq ENV["SLACK_PHASE_GUIDE_UPDATE_BOT_TOKEN"]
    end
  end
end
