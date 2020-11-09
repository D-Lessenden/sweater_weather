class BackgroundsService
  def self.return_background(coords)
    conn = Faraday.new('https://api.unsplash.com')
    response = conn.get("/photos?client_id=#{ENV['BACKGROUND-API']}&location[latitude]=#{coords[0]}&location[longitude]=#{coords[1]}")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
