class ForecastService
  def self.return_forecast(coords)
    conn = Faraday.new('https://api.openweathermap.org')
    response = conn.get("/data/2.5/onecall?units=imperial&lat=#{coords[0]}&lon=#{coords[1]}&exclude=minutely&appid=#{ENV['WEATHER-API']}")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
