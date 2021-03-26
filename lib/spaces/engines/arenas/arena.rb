require_relative 'boostrapping'
require_relative 'resolving'
require_relative 'providing'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Bootstrapping
    include ::Arenas::Resolving
    include ::Arenas::Providing

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints] => :universe)

    def runtime_binding
      @runtime_binding ||= turtle_targets.detect(&:runtime_binding?)
    end

    def payload
      [required_stanza, arena_stanzas].join
    end

    def embedding_keys; @embedding_keys ||= division_keys ;end

    def required_stanza
      %(
        terraform {
          required_providers {
            #{provider_divisions.flatten.map(&:required_stanza).flatten.compact.join}
          }
        }
      )
    end

    def arena_stanzas
      provider_divisions.map(&:arena_stanzas).flatten.compact.join
    end

    def arena; itself ;end

  end
end
