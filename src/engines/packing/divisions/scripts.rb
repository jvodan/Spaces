require_relative 'division'

module Packing
  class Scripts < ::Divisions::Division
    include ::Packing::Division

    alias_method :pack, :emission

    delegate(resolutions: :universe)

    def scripts_for(precedence)
      resolutions.file_names_for("#{path}/#{precedence}", context_identifier).map(&:basename)
    end

    def keys
      keys ||= precedence & script_directories.map { |d| :"#{d.basename}" }
    end

    def script_directories
      script_directories ||= resolutions.path_for(pack).join(path).children.select(&:directory?)
    end

    def packing_stanza_for(precedence)
      {
        type: 'shell',
        inline: scripts_for(precedence).map do |s|
          temporary_script_path.join("#{precedence}", s)
        end
      }
    end

  end
end
