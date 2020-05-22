require_relative '../../docker/files/step'

module Replacements
  module Steps
    class Run < Docker::Files::Step

      def instructions
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end