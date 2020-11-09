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

  def self.route(start, finish)
    conn = Faraday.new('https://www.mapquestapi.com')
    response = conn.get("/directions/v2/route?key=#{ENV['MAP-API']}&from=#{start}&to=#{finish}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
    json = JSON.parse(response.body, symbolize_names: true)
    json[:route][:distance]
  end
end
