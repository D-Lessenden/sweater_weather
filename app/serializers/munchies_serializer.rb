class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'munchie'

  attribute :restaurant do |data|
    {
      "name": data[:businesses][0][:name],
      "address": Munchies.convert_array(data[:businesses][0][:location][:display_address])
    }
  end

end
