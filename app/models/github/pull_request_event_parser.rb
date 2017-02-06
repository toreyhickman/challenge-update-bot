module Github
  module PullRequestEventParser
    def self.parse(payload)
      Github::PullRequestEvent.new({
        :action => extract_action(payload),
        :merge_status => extract_merge_status(payload),
        :repo_name => extract_repo_name(payload)
      })
    end

    private
    def self.extract_action(payload)
      payload["action"]
    end

    def self.extract_merge_status(payload)
      payload["pull_request"]["merged"]
    end

    def self.extract_repo_name(payload)
      payload["repository"]["name"]
    end
  end
end
