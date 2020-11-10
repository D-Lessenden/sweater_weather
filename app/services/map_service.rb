class MapService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.return_coords(location)
    coords = []
    response = conn.get("/geocoding/v1/address") do |f|
      f.params[:key] = ENV['MAP-API']
      f.params[:inFormat] = 'kvp'
      f.params[:outFormat] = 'json'
      f.params[:location] = location
      f.params[:thumbMaps] = 'false'
    end
    json = JSON.parse(response.body, symbolize_names: true)
    lat = json[:results].first[:locations].first[:latLng][:lat]
    lon = json[:results].first[:locations].first[:latLng][:lng]
    coords << lat
    coords << lon
    coords
  end

  def self.route(start, finish)
   conn = Faraday.new('https://www.mapquestapi.com')
   response = conn.get("/directions/v2/route?key=#{ENV['MAP-API']}&from=#{start}&to=#{finish}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
   json = JSON.parse(response.body, symbolize_names: true)
 end

 def self.convert_time(time)
   array = time.split(":")
   converted = array[0] + ' ' + 'hours' + ' ' + array[1] + ' ' + 'min'
 end
end
