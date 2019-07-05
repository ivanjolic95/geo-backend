module Geo
  class Parser
    attr_reader :provider

    def initialize(provider = Geo::Providers::RGeo.build)
      @provider = provider
    end

    def parse(json_data)
      @json_data = json_data
      return [] unless json_data
      return features if data.respond_to?(:map)
      data
    end

    private

    attr_reader :path, :json_data

    def data
      @data ||= @provider.parse(json_data)
    end

    def features
      data.map { |feature| feature }
    end
  end
end
