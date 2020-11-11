class MapFacade
  def self.return_coords(location)
    coords = MapService.return_coords(location)
  end

  def self.route(start, finish)
    route = MapService.route(start, finish)
  end
end
