class Location
  extend ActiveModel::Naming
  include Geo::Helpers

  attr_reader :json_data

  def initialize(json_data)
    @json_data = json_data
  end

  def as_json
    json_data
  end

  def geometry
    geo_parser.parse(as_json)
  end

  def is_inside_any_area?
    Area.any_contains?(self)
  end
end
