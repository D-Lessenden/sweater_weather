class ForecastService
  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end

  def self.return_forecast(coords)
    response = conn.get("/data/2.5/onecall") do |f|
      f.params[:lat] = coords[0]
      f.params[:lon] = coords[1]
      f.params[:exclude] = 'minutely'
      f.params[:units] = 'imperial'
      f.params[:appid] = ENV['WEATHER-API']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.weather_at_eta(coords, time)
    response = conn.get("/data/2.5/onecall") do |f|
      f.params[:lat] = coords[0]
      f.params[:lon] = coords[1]
      f.params[:exclude] = 'minutely'
      f.params[:units] = 'imperial'
      f.params[:appid] = ENV['WEATHER-API']
    end
    json = JSON.parse(response.body, symbolize_names: true)
    json[:hourly].find { |hour| hour if hour[:dt] == time }
  end
end
