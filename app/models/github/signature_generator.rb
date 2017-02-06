module Github
  module SignatureGenerator
    def self.generate_signature(raw_request_body)
      "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["GITHUB_WEBHOOK_SECRET"], raw_request_body)
    end
  end
end
