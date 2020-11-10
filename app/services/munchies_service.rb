class MunchiesService
  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP-API']}"
    end
  end

  def self.return_restaurant(coords, arrival, term)
    response = conn.get('/v3/businesses/search') do |f|
      f.params[:term] = term
      f.params[:latitude] = coords[0]
      f.params[:longitude] = coords[1]
      f.params[:open_at] = arrival
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
