module Publishing
  class Blueprint < Emissions::Emission

    delegate(publications: :universe)

    attr_accessor :descriptor

    def descriptor
      @descriptor ||= descriptor_class.new(repository: repository, branch: branch)
    end

    def repository
      opened.remote.url
    end

    def branch
      opened.branches.local.detect(&:current).name
    end

    def opened
      @opened ||= publications.open_for(self)
    end

  end
end
