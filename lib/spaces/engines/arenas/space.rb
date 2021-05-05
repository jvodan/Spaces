require_relative 'terraforming'

module Arenas
  class Space < ::Spaces::Space
    include ::Arenas::Terraforming

    class << self
      def default_model_class
        Arena
      end
    end

    delegate([:resolutions, :packs, :provisioning] => :universe)

    alias_method :identifiers, :simple_identifiers

    def dependent_spaces; [resolutions, packs, provisioning] ;end

    def reset_resolutions_for(model)
      model.bound_resolutions.map { |r| resolutions.reset(r) }
    end

    def save(model)
      super.tap do
        artifact_file_name_for(model).write(model.artifact)
      end
    end

    def save_initial(model)
      initial_file_name_for(model).write(model.initial_artifact)
    end

    def delete(identifiable)
      super.tap do
        dependent_spaces.each do |s|
          if (p = s.path.join(identifiable.identifier)).exist?
            p.rmtree
          end
        end
      end
    end

    def artifact_file_name_for(model)
      path_for(model).join("_arena.#{artifact_extension}")
    end

    def initial_file_name_for(model)
      path_for(model).join("_initial.#{artifact_extension}")
    end

    def path_for(model)
      model.respond_to?(:arena) ? path.join(model.arena.context_identifier) : super
    end

    def artifact_extension; :tf ;end

  end

  module Errors
    class ProvisioningError < ::Spaces::Errors::SpacesError
    end
  end
end
