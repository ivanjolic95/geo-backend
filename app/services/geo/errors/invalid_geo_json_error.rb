module Geo
  class Errors::InvalidGeoJSONError < StandardError
    def initialize(msg = "Invalid GeoJSON was provided, please check your syntax")
      super
    end
  end
end
