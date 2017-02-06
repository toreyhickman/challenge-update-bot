module Github
  class RequestAuthenticator
    attr_reader :signature_generator

    def initialize(signature_generator = Github::SignatureGenerator)
      @signature_generator = signature_generator
    end

    def valid_signature?(github_request)
      Rack::Utils.secure_compare(expected_signature(github_request), github_request.signature)
    end

    private
    def expected_signature(github_request)
      signature_generator.generate_signature(github_request.raw_body)
    end
  end
end
