class Api::V1::BackgroundsController < ApplicationController
  def show
    coords = MapFacade.return_coords(params[:location])
    render json: BackgroundsSerializer.new(BackgroundsFacade.return_background(coords))
  end
end
