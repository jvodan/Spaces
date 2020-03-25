require_relative '../spaces/model'
require_relative '../images/collaboration'

module FilePermissions
  class FilePermission < ::Spaces::Model
    include Images::Collaboration

    relation_accessor :context

    def recursive?
      struct.recursive
    end

    def subspace_path
      context.subspace_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end