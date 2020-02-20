require_relative '../../docker/files/step'

module OsPackages
  module Steps
    class RunScripts < Docker::Files::Step

      def content
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end