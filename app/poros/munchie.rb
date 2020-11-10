class Munchie
  attr_reader :forecast, :restaurant, :destination, :city

  def initialize(params)
    @forecast = params[:forecast]
    @restaurant = params[:restaurant]
    @destination = params[:destination]
    @city = params[:city]
  end
end
