class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}

  attributes :image do |data|
    {
      location: data[:location],
      image_url_raw: data[:json][:results][0][:urls][:raw],
      image_url_full: data[:json][:results][0][:urls][:full],
      image_url_regular: data[:json][:results][0][:urls][:regular],
      credit: {
                creator: data[:json][:results][0][:user][:username],
                portfolio: data[:json][:results][0][:user][:portfolio_url]
              }
    }
  end
end
