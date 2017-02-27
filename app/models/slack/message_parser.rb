module Slack
  module MessageParser
    DEFAULT_CHANNEL = "#general"
    DEFAULT_HEADING = "A pull request was merged!"

    def self.parse_github_pull_request_event(pull_request_event, channel = DEFAULT_CHANNEL, heading = DEFAULT_HEADING)
      {
        :channel     => channel,
        :as_user     => true,
        :attachments => [{
          :title   => pull_request_event.repo_name,
          :pretext => heading,
          :text    => "#{pull_request_event.title}\n#{pull_request_event.url}"
        }]
      }
    end
  end
end
