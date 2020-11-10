class Api::V1::MunchiesController < ApplicationController
  def show
    # binding.pry
    coords = MapFacade.return_coords(params[:end])

    conn = Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP-API']}"
    end
    response = conn.get("/v3/businesses/search?term=#{params[:food]}&latitude=#{coords[0]}&longitude=#{coords[1]}&limit=1")
    json = JSON.parse(response.body, symbolize_names: true)

    render json: MunchiesSerializer.new(json)

  end
end
#[38.265425, -104.610415] pueblo coords









# GET https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972
