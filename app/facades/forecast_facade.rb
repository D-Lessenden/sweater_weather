class ForecastFacade
  def self.return_forecast(coords)
    ForecastService.return_forecast(coords)
  end
end
