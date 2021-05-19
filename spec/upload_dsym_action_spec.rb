describe Fastlane::Actions::UploadDsymAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The upload_dsym plugin is working!")

      Fastlane::Actions::UploadDsymAction.run(nil)
    end
  end
end
