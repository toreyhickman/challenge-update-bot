module Github
  module RequestParser
    def self.parse(sinatra_request)
      Github::Request.new({
        :signature => extract_signature(sinatra_request),
        :payload   => extract_payload(sinatra_request),
        :raw_body  => extract_raw_body(sinatra_request)
      })
    end

    private
    def self.extract_signature(sinatra_request)
      sinatra_request.env["HTTP_X_HUB_SIGNATURE"] || ""
    end

    def self.extract_payload(sinatra_request)
      JSON.parse(sinatra_request.params["payload"] || "{}")
    end

    def self.extract_raw_body(sinatra_request)
      sinatra_request.body.rewind
      sinatra_request.body.read
    end
  end
end
