require_relative "../spec_helper"

describe Github::SignatureGenerator do
  let(:request_raw_body) { "payload={\"key\":\"value\"}" }

  it "generates a string beginning with 'sha1='" do
    signature = Github::SignatureGenerator.generate_signature(request_raw_body)
    expect(signature).to match /\Asha1=/
  end

  it "generates the same signature given the same input" do
    signature_1 = Github::SignatureGenerator.generate_signature(request_raw_body)
    signature_2 = Github::SignatureGenerator.generate_signature(request_raw_body)
    expect(signature_1).to eq signature_2
  end

  it "generates different signatures for different inputs" do
    signature_1 = Github::SignatureGenerator.generate_signature(request_raw_body)
    signature_2 = Github::SignatureGenerator.generate_signature("other_body")
    expect(signature_1).to_not eq signature_2
  end
end
