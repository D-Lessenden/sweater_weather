class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: BackgroundsSerializer.new(BackgroundsFacade.return_background(params[:location]))
  end
end
