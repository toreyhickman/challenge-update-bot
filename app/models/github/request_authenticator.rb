module Github
  module RequestAuthenticator
    def self.valid_signature?(github_request, signature_generator = Github::SignatureGenerator)
      actual_signature = github_request.signature
      expected_signature = expected_signature(github_request, signature_generator)

      Rack::Utils.secure_compare(actual_signature, expected_signature)
    end

    private
    def self.expected_signature(github_request, signature_generator)
      signature_generator.generate_signature(github_request.raw_body)
    end
  end
end
