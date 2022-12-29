require "rails_helper"

RSpec.describe GroupJob, type: :job do
  describe '#perform_later' do
    context 'RSpecの have_enqueued_job マッチャを用いる' do
      it "名前付きキューに１回入ること" do
        expect {
          GroupJob.perform_later
        }.to have_enqueued_job(GroupJob).exactly(:once)
      end
    end
  end
end