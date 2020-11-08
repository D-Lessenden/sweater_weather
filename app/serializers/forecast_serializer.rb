class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'forecast'

  attributes :current_weather do |data|
    {
      datetime: Forecast.convert_time(data[:current][:dt]),
      sunrise: Forecast.convert_time(data[:current][:sunrise]),
      sunset: Forecast.convert_time(data[:current][:sunset]),
      temperature: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
  end

  def self.daily(data)
    data.map do |daily_weather|
      {
        datetime: Forecast.convert_date(daily_weather[:dt]),
        sunrise: Forecast.convert_time(daily_weather[:sunrise]),
        sunset: Forecast.convert_time(daily_weather[:sunset]),
        max_temp: daily_weather[:temp][:max],
        min_temp: daily_weather[:temp][:min],
        conditions: daily_weather[:weather][0][:description],
        icon: daily_weather[:weather][0][:icon]
      }
    end
  end

  attributes :daily_weather do |data|
    daily(data[:daily][0..4])
  end

  def self.hourly(data)
    data.map do |hourly_weather|
      {
        datetime: Forecast.convert_time(hourly_weather[:dt]),
        wind_speed: hourly_weather[:wind_speed],
        wind_direction: Forecast.wind_direction(hourly_weather[:wind_deg]),
        conditions: hourly_weather[:weather][0][:description],
        icon: hourly_weather[:weather][0][:icon],
      }
    end
  end

  attributes :hourly_weather do |data|
    hourly(data[:hourly][0..7])
  end

end
