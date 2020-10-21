module Resolving
  class Resolution < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      resolution: :itself,
      resolutions: :universe
    )

    alias_accessor :blueprint, :predecessor

    def emit
      super.tap { |m| m.identifier = struct.identifier }
    end

    def auxiliary_texts
      [files_for(:injections)].flatten
    end

    def files_for(directory)
      [
        resolutions.unresolved_names_for(directory),
        blueprint_file_names_for(directory)
      ].flatten.compact.map do |t|
        interpolating_class.new(origin: t, directory: directory, division: self)
      end
    end

    def division_map
      @resolution_division_map ||= super.merge(
        mandatory_keys.reduce({}) do |m, k|
          m.tap { m[k] = division_for(k) }
        end.compact
      )
    end

    def binding_descriptors
      has?(:bindings) ? bindings.all.map(&:descriptor) : []
    end

    def initialize(struct: nil, blueprint: nil, identifier: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.identifier = identifier if identifier
    end

  end
end
