require_relative "../spec_helper"

describe Github::RequestParser do
  describe "parsing a request into a Github::Request" do
    before(:each) do
      post "/challenge-updates", "payload={\"key\":\"value\"}", { "HTTP_X_HUB_SIGNATURE" => "sha1=xyz" }
    end

    it "returns an object with the request's signature" do
      parsed_request = Github::RequestParser.parse(last_request)
      expect(parsed_request.signature).to eq "sha1=xyz"
    end

    it "returns an object with the request's payload" do
      parsed_request = Github::RequestParser.parse(last_request)
      expect(parsed_request.payload).to eq JSON.parse("{\"key\":\"value\"}")
    end

    it "returns an object with the request's raw body" do
      parsed_request = Github::RequestParser.parse(last_request)
      expect(parsed_request.raw_body).to eq "payload={\"key\":\"value\"}"
    end

    context "when no signature recieved" do
      before(:each) do
        post "/challenge-updates", "payload={\"key\":\"value\"}"
      end

      it "returns an object with an empty signature" do
        parsed_request = Github::RequestParser.parse(last_request)
        expect(parsed_request.signature).to eq ""
      end
    end

    context "when no payload recieved" do
      before(:each) do
        post "/challenge-updates", "", { "HTTP_X_HUB_SIGNATURE" => "sha1=xyz" }
      end

      it "returns an object with an empty payload" do
        parsed_request = Github::RequestParser.parse(last_request)
        expect(parsed_request.payload).to eq({})
      end

      it "returns an object with an empty raw body" do
        parsed_request = Github::RequestParser.parse(last_request)
        expect(parsed_request.raw_body).to eq ""
      end
    end
  end
end
