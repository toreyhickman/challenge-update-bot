require_relative "../spec_helper"

class SomeClass
  include AnnouncementJudge
end

describe "AnnouncementJudge helpers" do
  describe "determining whether to announce a pull request event" do
    let(:subject) { SomeClass.new }

    context "when not for a merged pull request" do
      it "returns false" do
        pull_request_event = double("event", {
          :merged_pull_request? => false,
          :merge_to_master? => true,
          :for_a_challenge? => true,
          :for_a_phase_guide? => false
        })

        expect(subject.announceable?(pull_request_event)).to be false
      end
    end

    context "when for a merged pull request" do
      context "when the merge is not to master" do
        it "returns false" do
          pull_request_event = double("event", {
            :merged_pull_request? => true,
            :merge_to_master? => false,
            :for_a_challenge? => true,
            :for_a_phase_guide? => false
          })

          expect(subject.announceable?(pull_request_event)).to be false
        end
      end

      context "when the merge is to master" do
        context "when for a challenge repo" do
          it "returns true" do
          pull_request_event = double("event", {
            :merged_pull_request? => true,
            :merge_to_master? => true,
            :for_a_challenge? => true,
            :for_a_phase_guide? => false
          })

          expect(subject.announceable?(pull_request_event)).to be true
          end
        end

        context "when for a phase guide repo" do
          it "returns true" do
            pull_request_event = double("event", {
              :merged_pull_request? => true,
              :merge_to_master? => true,
              :for_a_challenge? => false,
              :for_a_phase_guide? => true
            })

            expect(subject.announceable?(pull_request_event)).to be true
          end
        end

        context "when for neither a challenge nor a phase guide" do
          it "returns false" do
            pull_request_event = double("event", {
              :merged_pull_request? => true,
              :merge_to_master? => true,
              :for_a_challenge? => false,
              :for_a_phase_guide? => false
            })

            expect(subject.announceable?(pull_request_event)).to be false
          end
        end
      end
    end
  end
end
