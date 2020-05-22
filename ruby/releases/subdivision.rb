require_relative 'component'

module Releases
  class Subdivision < Component

    relation_accessor :division

    delegate([:stage, :release_path, :context_identifier] => :division)

    def initialize(struct:, division:)
      self.struct = struct
      self.division = division
    end

  end
end