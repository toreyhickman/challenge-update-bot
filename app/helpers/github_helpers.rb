module GitHubHelpers
  def from_github?
    request.body.rewind
    payload_body = request.body.read
    signature_verified?(payload_body)
  end

  private
  def signature_verified?(payload_body)
    Rack::Utils.secure_compare(expected_signature(payload_body), received_signature)
  end

  def expected_signature(payload_body)
    "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["GITHUB_WEBHOOK_SECRET"], payload_body)
  end

  def received_signature
    request.env["HTTP_X_HUB_SIGNATURE"] || ""
  end
end

helpers GitHubHelpers

