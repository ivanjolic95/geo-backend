module Geo
  class IsLocationPartOfAnyArea
    GEO_JSON_PARSE_ERROR_MSG = "Could not parse given GeoJSON:"
    JSON_PARSE_ERROR_MSG     = "Invalid JSON given:"
    OTHER_ERROR_MSG          = "There's been an issue determining if the location is inside any area"

    def self.build
      new
    end

    def call(location)
      begin
        Result::Success.new(location.is_inside_any_area?)
      rescue Geo::Errors::InvalidGeoJSONError => e
        Result::Failure.new.add_error "#{GEO_JSON_PARSE_ERROR_MSG} #{e.inspect}"
      rescue JSON::ParserError => e
        Result::Failure.new.add_error "#{JSON_PARSE_ERROR_MSG} #{e.inspect}"
      rescue StandardError => e
        Result::Failure.new.add_error OTHER_ERROR_MSG
      end
    end
  end
end
