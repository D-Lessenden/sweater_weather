class TrailsSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'trail'

  attributes :location do |data|
    {
      "location": data.location
    }
  end

  attributes :forecast do |data|
    {
      "summary": data.forecast[:current][:weather].first[:description],
      "temperature": data.forecast[:current][:temp]
    }
  end

  def self.trail_data(data, location)
    data.map do |trail|
      {
        "name": trail[:name],
        "summary": trail[:summary],
        "difficulty": trail[:difficulty],
        "location": trail[:location],
        "distance_to_trail": MapService.route(location, trail[:location])
      }
    end
  end

  attributes :trails do |data|
    trail_data(data.trails, data.location)
  end


end
