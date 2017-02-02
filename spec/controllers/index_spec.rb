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
    it "responds with a 200 status code" do
      make_authenticated_request
      expect(last_response.status).to eq 200
    end
  end
end
