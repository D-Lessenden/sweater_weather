class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'roadtrip'

  attributes :travel_time do |data|
    MapService.convert_time(data.route[:route][:formattedTime])
  end

  attributes :start_city do |data|
    data.start_city
  end

  attributes :end_city do |data|
    data.end_city
  end

  attributes :weather_at_eta do |data|
    {
      temperature: ForecastService.weather_at_eta([data.forecast[:lat], data.forecast[:lon]], MapService.time_of_arrival(data.route[:route][:time]))[:temp],
      conditions: ForecastService.weather_at_eta([data.forecast[:lat], data.forecast[:lon]], MapService.time_of_arrival(data.route[:route][:time]))[:weather].first[:description]
    }
  end
end
