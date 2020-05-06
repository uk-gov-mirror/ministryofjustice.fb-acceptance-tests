RSpec.describe Fb::Integration::CLI do
  describe '#run' do
    let(:repository) do
      Fb::Integration::Repository.new(name: 'foo', destination: 'foo')
    end
    let(:repositories) do
      [repository]
    end

    context 'when setup type is already defined' do
      it 'setup all repositories' do
        allow(Fb::Integration).to receive(:repositories).and_return(repositories)
      end
    end

    context 'when setup type is defined via CLI' do
    end
  end
end
