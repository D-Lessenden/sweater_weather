class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}

  attributes :image do |data|
    {
      image_url_raw: data[:urls][:raw],
      image_url_full: data[:urls][:full],
      image_url_regular: data[:urls][:regular],
      image_url_small: data[:urls][:small],
      image_url_thumb: data[:urls][:thumb],
      creator: data[:user][:username],
      portfolio: data[:user][:portfolio_url]
    }
  end


end
