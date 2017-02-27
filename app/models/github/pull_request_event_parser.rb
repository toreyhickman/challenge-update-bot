module Github
  module PullRequestEventParser
    def self.parse(payload)
      Github::PullRequestEvent.new({
        :action       => extract_action(payload),
        :merge_status => extract_merge_status(payload),
        :repo_name    => extract_repo_name(payload),
        :title        => extract_title(payload),
        :url          => extract_url(payload)
      })
    end

    private
    def self.extract_action(payload)
      payload["action"]
    end

    def self.extract_merge_status(payload)
      payload.fetch("pull_request", {}).fetch("merged", "")
    end

    def self.extract_repo_name(payload)
      payload.fetch("repository", {}).fetch("name", "")
    end

    def self.extract_title(payload)
      payload.fetch("pull_request", {}).fetch("title", "")
    end

    def self.extract_url(payload)
      payload.fetch("pull_request", {}).fetch("html_url", "")
    end
  end
end
