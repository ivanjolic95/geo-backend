class LocationCheckController < ApplicationController
  def create
    build_location

    if is_location_part_of_any_area.success?
      render json: {
        inside_any_given_area: is_location_part_of_any_area.payload
      }
    else
      render json: {
        errors: is_location_part_of_any_area.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def is_location_part_of_any_area
    @result ||= Geo::IsLocationPartOfAnyArea.build.call(@location)
  end

  def build_location
    @location = Location.new(location_params)
  end

  def location_params
    params.permit(:type, coordinates: []).to_h
  end
end
