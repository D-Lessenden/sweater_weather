class Trails
  attr_reader :location, :forecast, :trails

  def initialize(params)
    @location = params[:location]
    @forecast = params[:forecast]
    @trails = (params[:trails][:trails])
  end

end
