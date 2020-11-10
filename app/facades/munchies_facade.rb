class MunchiesFacade
  def self.return_restaurant(coords, arrival, term)
    MunchiesService.return_restaurant(coords, arrival, term)
  end
end
