class Trails
  attr_reader :location, :forecast, :trails

  def initialize(params)
    @location = params[:location]
    @forecast = params[:forecast]
    @trails = trails_response(params[:trails][:trails])
  end

  def trails_response(params)

    trails = []
    params.each do |trail|
      # data = {}
      # attributes = {}
      # attrbiutes[:location] = @location
      # attributes[:forecast] = @forecast
        binding.pry
        trail[:name] = [:name]
        trail[:summary] = [:summary]
        trail[:difficulty] = [:difficulty]
        trail[:location] = [:location]
        trail[:distance_to_travel] = MapService.route(@locaion, trail[:location])



    end
  end
end
