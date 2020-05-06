RSpec.describe Fb::Integration::Options do
  subject(:options) { described_class.new(args) }

  describe '#install' do
    let(:args) { '-v' }

    context 'when is present' do
      it 'returns true' do
        options.install = true
        expect(options.install?).to be_truthy
      end
    end

    context 'when is nil' do
      it 'returns false' do
        options.install = nil
        expect(options.install?).to be_falsey
      end
    end
  end

  describe '#parse' do
    context 'when parse --all option' do
      let(:args) { '--all' }
      let(:repository) do
        double(name: 'fb-submitter', destination: 'submitter')
      end
      let(:repositories) do
        [repository]
      end
      before do
        allow(
          Fb::Integration
        ).to receive(:repositories).and_return(repositories)
        options.parse
      end

      it 'assigns to install repositories' do
        expect(options.install).to be(true)
      end

      it 'assign all repositories' do
        expect(options.setup_repositories).to eq([
          { name: 'fb-submitter', type: 'remote' }
        ])
      end
    end

    context 'when parse --all with one individual as remote' do
      let(:args) { ['--all', '--submitter'] }
      let(:repository) do
        double(name: 'fb-submitter', destination: 'submitter')
      end
      let(:repositories) do
        [repository]
      end
      before do
        allow(
          Fb::Integration
        ).to receive(:repositories).and_return(repositories)
        options.parse
      end

      it 'assigns to install repositories' do
        expect(options.install).to be(true)
      end

      it 'assign all repositories without duplicating' do
        expect(options.setup_repositories).to eq([
          { name: 'fb-submitter', type: 'remote' }
        ])
      end
    end

    context 'when parse --all with one individual as local' do
      let(:args) { ['--all', '--submitter-local'] }
      let(:repository) do
        double(name: 'fb-submitter', destination: 'submitter')
      end
      let(:repositories) do
        [repository]
      end
      before do
        allow(
          Fb::Integration
        ).to receive(:repositories).and_return(repositories)
        options.parse
      end

      it 'assigns to install repositories' do
        expect(options.install).to be(true)
      end

      it 'assign all repositories' do
        expect(options.setup_repositories).to eq([
          { name: 'fb-submitter', type: 'local' }
        ])
      end
    end

    context 'when parse --update option' do
      let(:args) { ['--update', 'submitter'] }
      let(:repository) do
        double(name: 'fb-submitter', destination: 'submitter')
      end
      let(:repositories) do
        [repository]
      end
      before do
        allow(
          Fb::Integration
        ).to receive(:repositories).and_return(repositories)
        options.parse
      end

      it 'do not install repositories' do
        expect(options.install).to be(false)
      end

      it 'assign all repositories' do
        expect(options.setup_repositories).to eq([
          { name: 'fb-submitter', type: 'local' }
        ])
      end
    end

    context 'when parse unknown option' do
      context 'when repository exists' do
        let(:repository) do
          double(name: 'fb-submitter', destination: 'submitter')
        end
        let(:repositories) do
          [repository]
        end
        before do
          allow(
            Fb::Integration
          ).to receive(:repositories).and_return(repositories)
          options.parse
        end

        context 'when not passing any type' do
          let(:args) { '--submitter' }

          it 'adds to setup repositories option with remote as default' do
            expect(options.setup_repositories).to eq(
              [{ name: 'fb-submitter', type: 'remote' }]
            )
          end
        end

        context 'when passing a type' do
          let(:args) { '--submitter-local' }

          it 'adds to setup repositories option with local as type' do
            expect(options.setup_repositories).to eq(
              [{ name: 'fb-submitter', type: 'local' }]
            )
          end
        end
      end

      context 'when repository does not exist' do
        let(:args) { '--submitter' }

        it 'returns empty setup repositories option' do
          allow(Fb::Integration).to receive(:repositories).and_return([])
          expect {
            options.parse
          }.to raise_error(
            OptionParser::InvalidOption,
            'invalid option: --submitter'
          )
        end
      end
    end

    context 'when parse install option' do
      let(:args) { '--install' }
      before { options.parse }

      it 'returns install option as true' do
        expect(options.install).to be(true)
      end
    end
  end
end
