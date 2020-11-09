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

  def self.trail_data(data)
    data.map do |trail|
      binding.pry 
      {
        "name": trail[:name],
        "summary": trail[:summary],
        "difficulty": trail[:difficulty],
        "location": trail[:location]
        # "distance_to_trail": MapService.route(, trail[:location])
      }
    end
  end

  attributes :trails do |data|
    binding.pry
    trail_data(data.trails)
  end


end
