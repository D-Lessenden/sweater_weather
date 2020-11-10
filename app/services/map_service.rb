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
end
