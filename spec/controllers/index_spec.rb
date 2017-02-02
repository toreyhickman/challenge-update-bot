require_relative "../spec_helper"

describe "POST /challenge-updates" do
  context "when no authentication is provided" do
    it "responds with a 500 status code" do
      post "/challenge-updates"

      expect(last_response.status).to eq 500
    end
  end

  context "when authentication fails" do
    it "responds with a 500 status code" do
      post "/challenge-updates", {}, { "HTTP_X_HUB_SIGNATURE" => "sha1=wrong" }

      expect(last_response.status).to eq 500
    end
  end

  context "when authentication succeeds" do
    it "responds with a 200 status code" do
      request_body = "body"
      correct_authentication = "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["GITHUB_WEBHOOK_SECRET"], request_body)

      post "/challenge-updates", request_body, { "HTTP_X_HUB_SIGNATURE" => correct_authentication }

      expect(last_response.status).to eq 200
    end
  end
end
