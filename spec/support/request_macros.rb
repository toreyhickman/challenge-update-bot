module RequestMacros
  CURRICULUM_UPDATE_ROUTE = "/curriculum-updates"
  SIGNATURE_HEADER = "HTTP_X_HUB_SIGNATURE"

  def make_request_with_no_authentication
    post CURRICULUM_UPDATE_ROUTE
  end

  def make_unauthenticated_request
    post CURRICULUM_UPDATE_ROUTE, "", { SIGNATURE_HEADER => "sha1=wrong" }
  end

  def make_authenticated_request_for_merging_to_a_nonchallenge
    make_authenticated_request(build_payload(read_merge_non_challenge_fixture))
  end

  def make_authenticated_request_for_merging_to_a_challenge
    make_authenticated_request(build_payload(read_merge_challenge_fixture))
  end

  def make_authenticated_request_for_opening_a_pull_request
    make_authenticated_request(build_payload(read_open_non_challenge_fixture))
  end

  private
  def build_payload(payload)
    "payload=" + payload
  end

  def make_authenticated_request(request_body)
    post CURRICULUM_UPDATE_ROUTE, request_body, { SIGNATURE_HEADER => correct_signature(request_body) }
  end

  def correct_signature(request_body)
    "sha1=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV["GITHUB_WEBHOOK_SECRET"], request_body)
  end

  def read_merge_non_challenge_fixture
    File.read(APP_ROOT.to_path + "/spec/fixtures/merge_non_challenge_pull_request_payload.json")
  end

  def read_merge_challenge_fixture
    File.read(APP_ROOT.to_path + "/spec/fixtures/merge_challenge_pull_request_payload.json")
  end

  def read_open_non_challenge_fixture
    File.read(APP_ROOT.to_path + "/spec/fixtures/open_non_challenge_pull_request_payload.json")
  end
end
