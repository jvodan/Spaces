module Emissions
  module Targeting

    def turtles; turtle_targets.map(&:blueprint) ;end
    def turtle_targets; targets(:turtle_targets) ;end

    def unique_connections; connect_targets.uniq(&:uniqueness) ;end

    def connections; connect_targets.map{ |t| t.resolution_in(arena) } ;end
    def connect_targets; targets(:connect_targets) ;end

    def targets(type); bindings.send(type) ;end

  end
end