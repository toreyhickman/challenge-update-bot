class SlackPullRequestParser
  DEFAULT_CHANNEL = "#bot-testing"
  DEFAULT_HEADING = "A challence was updated!"

  def self.parse(pull_request_event, channel = DEFAULT_CHANNEL, heading = DEFAULT_HEADING)
    {
      :channel     => channel,
      :as_user     => true,
      :attachments => [{
        :title   => pull_request_event.repo_name,
        :pretext => "A challenge was updated!",
        :text    => "#{pull_request_event.title}\n#{pull_request_event.url}"
      }]
    }
  end
end
