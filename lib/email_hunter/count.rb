require 'faraday'
require 'json'

API_COUNT_URL = 'https://api.hunter.io/v2/email-count?'

module EmailHunter
  class Count
    attr_reader :data, :meta

    def initialize(domain)
      @domain = domain
    end

    def hunt
      response = apiresponse
      Struct.new(*response.keys).new(*response.values) unless response.empty?
    end

    private

    def apiresponse
      url = URI.parse(URI.encode("#{API_COUNT_URL}domain=#{@domain}"))
      response = Faraday.new(url).get
      response.success? ? JSON.parse(response.body, {symbolize_names: true}) : []
    end
  end
end
