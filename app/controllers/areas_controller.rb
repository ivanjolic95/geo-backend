class AreasController < ApplicationController
  def index
    get_areas

    render json: @areas
  end

  private

  def get_areas
    @areas = Area.as_json
  end
end
