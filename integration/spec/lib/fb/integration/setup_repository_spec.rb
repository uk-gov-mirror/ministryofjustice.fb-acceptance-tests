RSpec.describe Fb::Integration::SetupRepository do
  subject(:setup_repository) do
    described_class.new(repository: repository)
  end
  let(:repository) do
    double(
      name: 'foo',
      destination: 'bar',
      github: 'git@github.com:ministryofjustice/foo.git'
    )
  end

  describe '#execute' do
    context 'when setup type is blank' do
      let(:setup_type) { nil }

      it 'raises an error' do
        expect {
          setup_repository.execute(setup_type: setup_type)
        }.to raise_error('Setup type required for the repo: foo')
      end
    end

    context 'when setup type is local' do
      it 'copies dir from relative path' do
        expect(setup_repository).to receive(:run_command).with(
          command: 'ln -s ../foo .bar'
        )
        setup_repository.execute(setup_type: 'local')
      end
    end

    context 'when setup type is remote' do
      it 'copies dir from relative path' do
        expect(setup_repository).to receive(:run_command).with(
          command: 'git clone git@github.com:ministryofjustice/foo.git .bar'
        )
        setup_repository.execute(setup_type: 'remote')
      end
    end

    context 'when setup type is unknow' do
      let(:setup_type) { 'what-are-you-doing' }

      it 'raises an error' do
        expect {
          setup_repository.execute(setup_type: setup_type)
        }.to raise_error('Setup type unknown for: foo')
      end
    end
  end
end
