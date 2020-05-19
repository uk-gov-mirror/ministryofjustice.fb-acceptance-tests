RSpec.describe Fb::Integration::Repository do
  subject(:repository) do
    described_class.new(name: name, destination: destination)
  end
  let(:destination) { 'service-token-cache' }

  describe '#name' do
    let(:name) { 'fb-submitter' }

    it 'returns name' do
      expect(repository.name).to eq(name)
    end
  end

  describe '#destination' do
    let(:name) { 'fb-submitter' }
    let(:destination) { 'submitter' }

    it 'returns destination' do
      expect(repository.destination).to eq(destination)
    end
  end

  describe '#setup_type' do
    context 'when not sending in initialisation' do
      let(:repository) do
        described_class.new(name: 'foo', destination: destination)
      end

      it 'returns nil' do
        expect(repository.setup_type).to be_nil
      end

      it 'assigns setup type' do
        repository.setup_type = :local
        expect(repository.setup_type).to be(:local)
      end
    end

    context 'when sending in initialisation' do
      let(:repository) do
        described_class.new(
          name: 'foo',
          setup_type: :remote,
          destination: destination
        )
      end

      it 'returns setup type' do
        expect(repository.setup_type).to be(:remote)
      end
    end
  end

  describe '#github' do
    let(:name) { 'fb-submitter' }

    it 'returns repository on github' do
      expect(
        repository.github
      ).to eq('git@github.com:ministryofjustice/fb-submitter.git')
    end
  end
end
