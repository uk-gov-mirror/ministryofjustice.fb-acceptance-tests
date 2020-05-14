RSpec.describe Fb::Integration::DockerCompose do
  subject(:docker_compose) do
    described_class.new(repositories)
  end
  let(:repositories) do
    [
      double(
        name: 'foo',
        destination: 'bar',
        github: 'git@github.com:ministryofjustice/foo.git'
      ),
      double(
        name: 'fb-awesome',
        destination: 'awesome',
        github: 'git@github.com:ministryofjustice/fb-awesome.git'
      ),
    ]
  end

  describe '#execute' do
    it 'removes dir from file system' do
      expect(docker_compose).to receive(:run_command).with(
        command: 'docker-compose build --parallel bar-app awesome-app'
      )
      expect(docker_compose).to receive(:run_command).with(
        command: 'docker-compose up -d bar-app awesome-app'
      )
      docker_compose.execute
    end
  end
end
