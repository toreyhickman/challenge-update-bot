module RequestMacros
  def make_request_with_no_authentication
    post "/challenge-updates"
  end

  def make_unauthenticated_request
    post "/challenge-updates", {}, { "HTTP_X_HUB_SIGNATURE" => "sha1=wrong" }
  end

  def make_authenticated_request
    request_body = "body"
    correct_authentication = "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["GITHUB_WEBHOOK_SECRET"], request_body)

    post "/challenge-updates", request_body, { "HTTP_X_HUB_SIGNATURE" => correct_authentication }
  end
end
