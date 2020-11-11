class RoadTrip
  attr_reader :forecast, :start_city, :end_city, :route, :weather_at_eta
  def initialize(params)
    @forecast = params[:forecast]
    @start_city = params[:start_city]
    @end_city = params[:end_city]
    @route = params[:route]
  end
end
