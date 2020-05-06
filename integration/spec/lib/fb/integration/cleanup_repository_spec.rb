RSpec.describe Fb::Integration::CleanupRepository do
  subject(:cleanup_repository) do
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
    it 'removes dir from file system' do
      expect(cleanup_repository).to receive(:run_command).with(
        command: 'rm -rf .bar'
      )
      cleanup_repository.execute
    end
  end
end
