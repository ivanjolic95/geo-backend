module Geo
  class Providers::RGeo
    extend Forwardable

    def self.build
      new
    end

    def parse(json_data)
      result = RGeo::GeoJSON.decode(json_data)
      raise Errors::InvalidGeoJSONError unless result
      result
    end

    def contains?(area, location)
      location.within?(area)
    end
  end
end
