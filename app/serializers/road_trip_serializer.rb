class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'roadtrip'

  attributes :travel_time do |data|
    if data.route[:info][:messages].first == "We are unable to route with the given locations."
      "Impossible"
    else
    MapService.convert_time(data.route[:route][:formattedTime])
    end
  end

  attributes :start_city do |data|
    data.start_city
  end

  attributes :end_city do |data|
    data.end_city
  end

  attributes :weather_at_eta do |data|
    if data.route[:info][:messages].first == "We are unable to route with the given locations."
      nil
    else
      {
        temperature: ForecastService.weather_at_eta([data.forecast[:lat], data.forecast[:lon]], MapService.time_of_arrival(data.route[:route][:time]))[:temp],
        conditions: ForecastService.weather_at_eta([data.forecast[:lat], data.forecast[:lon]], MapService.time_of_arrival(data.route[:route][:time]))[:weather].first[:description]
      }
    end
  end
end
