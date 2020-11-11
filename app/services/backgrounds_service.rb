class BackgroundsService
  def self.conn
    conn = Faraday.new('https://api.unsplash.com')
  end

  def self.return_background(location)
    response = conn.get("/search/photos") do |f|
      f.params[:client_id] = ENV['BACKGROUND-API']
      f.params[:query] = location
      f.params[:page] = 1
    end
    {location: location, json: JSON.parse(response.body, symbolize_names: true)}
  end
end
