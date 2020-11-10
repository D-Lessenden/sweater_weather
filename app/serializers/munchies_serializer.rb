class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'munchie'

  attributes :destination_city do |data|
    {
      "destination_city": data.city
    }
  end

  attributes :travel_time do |data|
    {
      "travel_time": MapService.convert_time(data.destination[:route][:formattedTime])
    }
  end

  attributes :forecast do |data|
    {
      "summary": data.forecast[:current][:weather].first[:description],
      "temperature": data.forecast[:current][:temp]
    }
  end


  attribute :restaurant do |data|
    {
      "name": data.restaurant[:businesses][0][:name],
      "address": Munchies.convert_array(data.restaurant[:businesses][0][:location][:display_address])
    }
  end

end
