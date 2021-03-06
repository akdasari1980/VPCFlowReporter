require_relative '../../app/vpcfrS3Writer'
require_relative '../vpcfrTestData'

module VPCFR

  # VPCFRS3Writer test
  RSpec.describe 'A correct s3 writer' do

    # Basic parameter tests. Note we do not test actually talking to S3,
    # that is done in the integration test.
    it 'can parse the destination to bucket and key elements' do
      writer = VPCFRS3Writer.new(VPCFRTestData.awsAccessKeyID,
        VPCFRTestData.awsSecretAccessKey, VPCFRTestData.awsRegion)
      writer.destination = VPCFRTestData.awsS3URI
      expect(writer.bucket).to eq(VPCFRTestData.awsS3Bucket)
      expect(writer.key).to eq(VPCFRTestData.awsS3Key)
    end
  end
end
