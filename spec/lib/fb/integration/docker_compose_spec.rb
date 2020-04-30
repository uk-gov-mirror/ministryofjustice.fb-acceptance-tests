RSpec.describe Fb::Integration::DockerCompose do
  subject(:docker_compose) do
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
      expect(docker_compose).to receive(:run_command).with(
        command: 'docker-compose up -d --build bar-app'
      )
      docker_compose.execute
    end
  end
end
