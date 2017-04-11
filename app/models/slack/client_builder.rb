module Slack
  module ClientBuilder
    def self.build_client(pull_request_event)
      Slack::Web::Client.new(token: token_for_event(pull_request_event))
    end

    private

    def self.token_for_event(pull_request_event)
      return ENV["SLACK_CHALLENGE_UPDATE_BOT_TOKEN"]   if pull_request_event.for_a_challenge?
      return ENV["SLACK_PHASE_GUIDE_UPDATE_BOT_TOKEN"] if pull_request_event.for_a_phase_guide?
    end
  end
end
