require_relative "../spec_helper"

describe Github::Request do
  describe "attributes" do
    let(:request_signature) { "sha1=somethingorother" }
    let(:request_raw_body)  { "payload={}" }
    let(:request_payload)   { double("payload") }

    let!(:github_request) do
      Github::Request.new({
        :signature => request_signature,
        :raw_body  => request_raw_body,
        :payload   => request_payload
      })
    end


    describe "the signature" do
      it "is readable" do
        expect(github_request.signature).to be request_signature
      end

      it "defaults to an empty string" do
        expect(Github::Request.new.signature).to eq ""
      end
    end

    describe "the raw body" do
      it "is readable" do
        expect(github_request.raw_body).to be request_raw_body
      end

      it "defaults to an empty string" do
        expect(Github::Request.new.raw_body).to eq ""
      end
    end

    describe "the payload" do
      it "is readable" do
        expect(github_request.payload).to be request_payload
      end

      it "defaults to an empty hash" do
        expect(Github::Request.new.payload).to eq Hash.new
      end
    end
  end
end
