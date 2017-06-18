require_relative '../../app/vpcfrConfig'

def setDefaultEnvironment
  ENV['AWS_ACCESS_KEY_ID'] = 'defaultAwsAccessKeyID'
  ENV['AWS_SECRET_ACCESS_KEY'] = 'defaultAwsSecretAccessKey'
  ENV['AWS_REGION'] = 'defaultAwsRegion'
  ['source','destination']
end

module VPCFR
  RSpec.describe 'A correct configuration' do

    it 'has the correct default settings' do
      args = setDefaultEnvironment
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can change its aggregate column to a custom value' do
      setDefaultEnvironment
      args = ['-a','logstatus','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'logstatus',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can change its check column to a custom value' do
      setDefaultEnvironment
      args = ['-c','logstatus','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'logstatus', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its destination type set to file' do
      setDefaultEnvironment
      args = ['-d','file','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion', checkCol: 'action', pattern: 'REJECT',
        version: '1.0', source: 'source', destination: 'destination',
        delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRFileWriter)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its formatter set to delimited' do
      args = ['-f','delimited','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its formatter set to delimited with a custom delimiter' do
      args = ['-f','delimited','--delimiter',';','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ';', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its formatter set to delimited with a space delimiter' do
      args = ['-f','delimited','--space','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ' ', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can have its aws parameters set to custom values' do
      setDefaultEnvironment
      args = ['-i','awskey','-k','awssecret','-r','awsregion','source',
        'destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'awskey', awsSecretAccessKey: 'awssecret',
        awsRegion: 'awsregion', checkCol: 'action',
        pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can check for a custom pattern' do
      args = ['-p','ACCEPT','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'srcaddr',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'ACCEPT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ',', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRJSONFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)
    end

    it 'can run in raw mode (no aggregate, space delimited)' do
      args = ['--raw','source','destination']
      config = VPCFRConfig.new(args)

      expect(config).to have_attributes(aggregateCol: 'none',
        awsAccessKeyID: 'defaultAwsAccessKeyID',
        awsSecretAccessKey: 'defaultAwsSecretAccessKey',
        awsRegion: 'defaultAwsRegion',
        checkCol: 'action', pattern: 'REJECT', version: '1.0', source: 'source',
        destination: 'destination', delimiter: ' ', message: '')
      expect(config.isGood?).to eq(true)
      expect(config.formatter).to be_instance_of(VPCFRDelimitedFormatter)
      expect(config.reader).to be_instance_of(VPCFRFileReader)
      expect(config.writer).to be_instance_of(VPCFRS3Writer)
      expect(config.parser).to be_instance_of(VPCFRParser)

    end

    it 'will create the help banner message' do
      args = ['-h','source','destination']
      config = VPCFRConfig.new(args)

      expect(config.message).not_to eq('')
    end

    it 'will reject improper column names' do
      args = ['-a','badname','source','destination']
      config = VPCFRConfig.new(args)

      expect(config.isGood?).to eq(false)
      expect(config.message).not_to eq('')
    end

    it 'will reject improper options' do
      args = ['-x','source','destination']
      config = VPCFRConfig.new(args)

      expect(config.isGood?).to eq(false)
      expect(config.message).not_to eq('')
    end

  end
end