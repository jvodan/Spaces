require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def unsaved_resolutions; unsaved_settlements_of(:resolution) ;end

    def bound_resolutions; resolution_map.values ;end

    def resolution_map; bound_settlement_map_for(:resolution) ;end

  end
end
