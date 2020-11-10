class Munchie
  attr_reader :forecast, :restaurant, :destination

  def initialize(params)
    @forecast = params[:forecast]
    @restaurant = params[:restaurant]
    @destination = (params[:destination])
  end
end
