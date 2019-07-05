class Area
  extend ActiveModel::Naming

  AREA_DATA_PATH = 'data/Given_areas.json'.freeze

  class << self
    include Geo::Helpers

    def all
      geo_parser.parse as_json
    end

    def as_json
      JSON.parse(File.read(AREA_DATA_PATH)).to_json
    end

    def any_contains?(location)
      area_geometries.any? { |area| contains?(area, location) }
    end

    private

    def area_geometries
      all.map(&:geometry)
    end

    def contains?(area, location)
      provider.contains?(area, location.geometry)
    end

    def provider
      geo_parser.provider
    end
  end
end
