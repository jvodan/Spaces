require_relative '../collaborators/division'
require_relative 'package'

module Packages
  class Packages < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def script_lot; end
      def inheritance_paths; __dir__; end
    end

    require_files_in :steps

  end
end
