module Github
  class Request
    attr_reader :signature, :raw_body, :payload

    def initialize(args ={})
      @signature = args.fetch(:signature, "")
      @raw_body  = args.fetch(:raw_body, "")
      @payload   = args.fetch(:payload, Hash.new)
    end
  end
end
