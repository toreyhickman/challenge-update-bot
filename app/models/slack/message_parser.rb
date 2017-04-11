module Slack
  module MessageParser
    DEFAULT_CHANNEL = "#general"

    def self.parse_github_pull_request_event(pull_request_event, channel = DEFAULT_CHANNEL)
      {
        :channel     => channel,
        :as_user     => true,
        :attachments => [{
          :title   => pull_request_event.repo_name,
          :pretext => generate_pretext(pull_request_event),
          :text    => "#{pull_request_event.title}\n#{pull_request_event.url}"
        }]
      }
    end

    private

    def self.generate_pretext(pull_request_event)
      return "A challenge was updated!"   if pull_request_event.for_a_challenge?
      return "A phase guide was updated!" if pull_request_event.for_a_phase_guide?
    end
  end
end
