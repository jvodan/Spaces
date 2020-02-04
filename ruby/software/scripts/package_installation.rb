require_relative 'requires'

class Software
  class PackageInstallation < Spaces::Script

    relation_accessor :package

    def content
      [
        downloading,
        (extracting unless git?),
        placing
      ]
    end

    def downloading
      git? ? downloading_with_git : downloading_with_wget
    end

    def downloading_with_git
      "git clone #{options} --depth 1 -b #{branch} #{value} #{extracted_path}"
    end

    def downloading_with_wget
      "wget #{options} -O #{identifier} #{value}"
    end

    def extracting
      %Q(
        cd /tmp/packages
  			#{extraction} #{identifier}
      )
    end

    def placing
      %Q(
        if test ! -d "./#{extracted_path}"
        then
          mkdir -p "#{destination_path}"
        fi

        if test -d "#{destination_path}"
        then
          if test -f  ./"#{extracted_path}"
          then
            cp -rp "./#{extracted_path}" #{destination_path}
          else
        		cp -rp "./#{extracted_path}/." #{destination_path}
        	fi
        else
          if ! test -d #{directory_name}
          then
         	  mkdir -p #{directory_name}
          fi
        	mv "./#{extracted_path}" #{destination_path}
        fi

        if test -f /tmp/packages/#{extracted_path}
        then
        	rm -rf /tmp/packages/#{extracted_path}
        fi
      )
    end

    def identifier
      descriptor.identifier
    end

    def branch
      descriptor.branch
    end

    def value
      descriptor.value
    end

    def extraction
      descriptor.extraction
    end

    def extracted_path
      descriptor.extracted_path
    end

    def destination_path
      descriptor.destination_path
    end

    def directory_name
      File.dirname(descriptor.destination_path)
    end

    def git?
      descriptor.protocol == 'git'
    end

    def descriptor
      package.descriptor
    end

    def options
    end

    def initialize(package)
      self.package = package
    end

  end
end