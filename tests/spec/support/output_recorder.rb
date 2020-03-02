module OutputRecorder
  def self.cleanup_recorded_requests
    HTTParty.delete(ENV.fetch('OUTPUT_RECORDER_ENDPOINT') + '/__admin/requests')
    p 'Deleted previous requests'
  end

  def self.wait_for_result(url:, expected_requests: 1)
    tries = 0
    max_tries = 20
    actual_requests = 0
    until actual_requests == expected_requests
      p "Waiting for requests to arrive at endpoint '#{url}'. Received #{actual_requests} of #{expected_requests} on try #{tries + 1} of #{max_tries}"
      sleep 1

      actual_requests = request_count(url: url)
      raise 'callback assertion timeout' if tries >= max_tries

      tries += 1
    end

    p "Received #{actual_requests} of #{expected_requests}"
    get_all_requests_made(url: url)
  end

  private

  def self.request_count(url:)
    HTTParty.post(
      ENV.fetch('OUTPUT_RECORDER_ENDPOINT') + '/__admin/requests/count',
      body: { method: 'POST', url: url }.to_json
    ).parsed_response.fetch('count', 0)
  end

  def self.get_all_requests_made(url:)
    res = HTTParty.post(
      ENV.fetch('OUTPUT_RECORDER_ENDPOINT') + '/__admin/requests/find',
      body: { method: 'POST', url: url }.to_json
    ).parsed_response

    res.fetch('requests').map { |r| r.fetch('body') }
  end
end
