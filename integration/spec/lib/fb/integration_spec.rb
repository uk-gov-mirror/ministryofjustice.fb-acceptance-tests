RSpec.describe Fb::Integration do
  describe '#repositores=' do
    after { Fb::Integration.repositories = [] }

    it 'returns instance of Fb::Integration::Repository' do
      described_class.repositories = [{ name: 'foo', destination: 'bar' }]
      expect(described_class.repositories.size).to be(1)
      expect(
        described_class.repositories.first
      ).to be_instance_of(Fb::Integration::Repository)
    end
  end

  describe '#find_repository' do
    let(:repository) { double(name: 'foo', destination: 'bar') }
    let(:repositories) do
      [repository]
    end

    context 'find by name' do
      it 'returns repository by name' do
        allow(Fb::Integration).to receive(:repositories).and_return(repositories)
        expect(Fb::Integration.find_repository('foo')).to be(repository)
      end
    end

    context 'find by destination' do
      it 'returns repository' do
        allow(Fb::Integration).to receive(:repositories).and_return(repositories)
        expect(Fb::Integration.find_repository('bar')).to be(repository)
      end
    end
  end
end
