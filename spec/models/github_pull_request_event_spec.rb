require_relative "../spec_helper"

describe Github::PullRequestEvent do
  let(:pull_request_event) do
    Github::PullRequestEvent.new({
      :action       => "closed",
      :merge_status => true,
      :repo_name    => "some-challenge"
    })
  end

  describe "the action" do
    it "is readable" do
      expect(pull_request_event.action).to eq "closed"
    end

    it "defaults to an empty string" do
      expect(Github::PullRequestEvent.new.action).to eq ""
    end
  end

  describe "the merge status" do
    it "is readable" do
      expect(pull_request_event.merge_status).to be true
    end

    it "defaults to false" do
      expect(Github::PullRequestEvent.new.merge_status).to be false
    end
  end

  describe "the repository name" do
    it "is readable" do
      expect(pull_request_event.repo_name).to eq "some-challenge"
    end

    it "defaults to an empty string" do
      expect(Github::PullRequestEvent.new.repo_name).to eq ""
    end
  end

  describe "being for a merged pull request" do
    context "when the action is closed and the merge status is true" do
      it "returns true" do
        expect(pull_request_event.merged_pull_request?).to be true
      end
    end

    context "when the action is not closed" do
      it "returns false" do
        pull_request_event = Github::PullRequestEvent.new(action: "open", merge_status: true)
        expect(pull_request_event.merged_pull_request?).to be false
      end
    end

    context "when the merge status is not true" do
      it "returns false" do
        pull_request_event = Github::PullRequestEvent.new(action: "closed", merge_status: false)
        expect(pull_request_event.merged_pull_request?).to be false
      end
    end
  end

  describe "being for a challenge repo" do
    context "when the pull request was made for a challenge repo" do
      it "returns true" do
        expect(pull_request_event.for_a_challenge?).to be true
      end
    end

    context "when the pull request was not made for a challenge repo" do
      it "returns false" do
        pull_request_event = Github::PullRequestEvent.new(repo_name: "some-repo")
        expect(pull_request_event.for_a_challenge?).to be false
      end
    end
  end
end
