require_relative "../spec_helper"

describe "POST /challenge-updates" do
  context "when no authentication is provided" do
    it "responds with a 500 status code" do
      make_request_with_no_authentication
      expect(last_response.status).to eq 500
    end
  end

  context "when authentication fails" do
    it "responds with a 500 status code" do
      make_unauthenticated_request
      expect(last_response.status).to eq 500
    end
  end

  context "when authentication succeeds" do
    context "when not for a merged pull request" do
      it "responds with a 422 status code" do
        make_authenticated_request_for_opening_a_pull_request
        expect(last_response.status).to eq 422
      end
    end

    context "when for a merged pull request" do
      context "when not for a challenge repository" do
        it "responds with a 422 status code" do
          make_authenticated_request_for_merging_to_a_nonchallenge
          expect(last_response.status).to eq 422
        end
      end

      context "when for a challenge repository" do
        it "responds with a 200 status code" do
          make_authenticated_request_for_merging_to_a_challenge
          expect(last_response.status).to eq 200
        end
      end
    end
  end
end
