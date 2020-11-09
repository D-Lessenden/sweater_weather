class MapService
  def self.return_coords(location)
    coords = []
    conn = Faraday.new('https://www.mapquestapi.com')
    response = conn.get("/geocoding/v1/address?key=#{ENV['MAP-API']}&inFormat=kvp&outFormat=json&location=#{location}&thumbMaps=false")
    json = JSON.parse(response.body, symbolize_names: true)
    lat = json[:results].first[:locations].first[:latLng][:lat]
    lon = json[:results].first[:locations].first[:latLng][:lng]
    coords << lat
    coords << lon
    coords
  end
end
