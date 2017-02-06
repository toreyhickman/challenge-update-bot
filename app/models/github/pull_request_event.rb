module Github
  class PullRequestEvent
    attr_reader :action, :merge_status, :repo_name

    def initialize(args = {})
      @action = args.fetch(:action, "")
      @merge_status = args.fetch(:merge_status, false)
      @repo_name = args.fetch(:repo_name, "")
    end

    def merged_pull_request?
      closed? && merged?
    end

    def for_a_challenge?
      repo_name.end_with?("challenge")
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
