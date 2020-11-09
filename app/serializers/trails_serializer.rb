class TrailsSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'trail'

  attributes :location do |data|
    binding.pry 
  end
  #
  # attributes :forecast do |data|
  #   {}
  # end

  def self.trail_data(data)
    data.map do |trail|
      {
        "name": trail[:name],
        "summary": trail[:summary],
        "difficulty": trail[:difficulty],
        "location": trail[:location]
        # "distance_to_trail": trail[:name]
      }
    end
  end

  attributes :trails do |data|
    trail_data(data[:trails])
  end




end
