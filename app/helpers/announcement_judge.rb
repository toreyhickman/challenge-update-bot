module AnnouncementJudge
  def announceable?(pull_request_event)
    return false unless pull_request_event.merged_pull_request?
    return false unless pull_request_event.merge_to_master?
    return true if pull_request_event.for_a_challenge?
    return true if pull_request_event.for_a_phase_guide?

    false
  end
end

helpers AnnouncementJudge
