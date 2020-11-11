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
   response = conn.get("/directions/v2/route") do |f|
     f.params[:key] = ENV['MAP-API']
     f.params[:from] = start
     f.params[:to] = finish
     f.params[:outFormat] = 'json'
     f.params[:ambiguities] = 'ignore'
     f.params[:routeType] = 'fastest'
     f.params[:doReverseGeocode] = 'false'
     f.params[:enhancedNarrative] = 'false'
     f.params[:avoidTimedConditions] = 'false'
   end
   json = JSON.parse(response.body, symbolize_names: true)
 end

 def self.convert_time(time)
   array = time.split(":")
   converted = array[0] + ' ' + 'hours' + ' ' + array[1] + ' ' + 'minutes'
 end

 def self.time_of_arrival(time)
    eta = DateTime.now.to_i + time
    arrival = Time.at(eta)
    arrival.beginning_of_hour.to_i
 end


end
