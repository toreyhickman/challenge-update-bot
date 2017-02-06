require_relative "../spec_helper"

describe Github::RequestAuthenticator do
  let(:signature_generator) { double("signature_generator") }
  let(:request_authenticator) { Github::RequestAuthenticator.new(signature_generator) }

  it "has a signature_generator" do
    expect(request_authenticator.signature_generator).to be signature_generator
  end

  describe "validating a request's signature" do
    context "when the given request has a valid signature" do
      it "returns true" do
        allow(signature_generator).to receive(:generate_signature).with("raw_body").and_return("sha1=valid")
        request = double("valid", raw_body: "raw_body", signature: "sha1=valid")

        expect(request_authenticator.valid_signature?(request)).to be true
      end
    end

    context "when the given request has an invalide signature" do
      it "returns false" do
        allow(signature_generator).to receive(:generate_signature).with("raw_body").and_return("sha1=valid")
        request = double("valid", raw_body: "raw_body", signature: "sha1=invalid")

        expect(request_authenticator.valid_signature?(request)).to be false
      end
    end
  end
end
