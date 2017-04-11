module Github
  class PullRequestEvent
    PHASE_GUIDE_REPO_NAME_PATTERN = /phase\-\d+\-guide/

    attr_reader :action, :merge_status, :repo_name, :title, :url

    def initialize(args = {})
      @action = args.fetch(:action, "")
      @merge_status = args.fetch(:merge_status, false)
      @repo_name = args.fetch(:repo_name, "")
      @title = args.fetch(:title, "")
      @url = args.fetch(:url, "")
    end

    def merged_pull_request?
      closed? && merged?
    end

    def for_a_challenge?
      repo_name.end_with?("challenge")
    end

    def for_a_phase_guide?
      !!repo_name.match(PHASE_GUIDE_REPO_NAME_PATTERN)
    end

    private
    def closed?
      action == "closed"
    end

    def merged?
      merge_status == true
    end
  end
end
