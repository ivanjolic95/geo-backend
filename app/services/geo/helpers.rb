module Geo
  module Helpers
    def geo_parser
      @geo_parser ||= Geo::Parser.new
    end
  end
end
