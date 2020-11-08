class Forecast
  def self.wind_direction(wing_deg)
    if wing_deg >= 348.76 || wing_deg <= 11.25
      'North'
    elsif wing_deg >= 11.26 && wing_deg <= 33.75
      'North North-East'
    elsif wing_deg >= 33.76 && wing_deg <= 56.25
      'North East'
    elsif wing_deg >= 56.26 && wing_deg <= 78.75
      'East North-East'
    elsif wing_deg >= 78.76 && wing_deg <= 101.25
      'East'
    elsif wing_deg >= 101.26 && wing_deg <= 123.75
      'East South-East'
    elsif wing_deg >= 123.76 && wing_deg <= 146.25
      'South East'
    elsif wing_deg >= 146.26 && wing_deg <= 168.75
      'South South-East'
    elsif wing_deg >= 168.76 && wing_deg <= 191.25
      'South'
    elsif wing_deg >= 191.26 && wing_deg <= 213.75
      'South South-West'
    elsif wing_deg >= 213.76 && wing_deg <= 236.25
      'South West'
    elsif wing_deg >= 236.26 && wing_deg <= 258.75
      'West South-West'
    elsif wing_deg >= 258.76 && wing_deg <= 281.25
      'West'
    elsif wing_deg >= 281.26 && wing_deg <= 303.75
      'West North-West'
    elsif wing_deg >= 303.76 && wing_deg <= 326.25
      'North West'
    elsif wing_deg >= 326.26 && wing_deg <= 348.75
      'North North-West'
    end
  end

  def self.convert_time(data)
    time = Time.at(data)
  end

  def self.convert_date(data)
    time = Time.at(data)
    date = time.to_date.to_s
  end
end
