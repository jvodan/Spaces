require 'git'

module Git
  class Space < ::Spaces::Space

    def encloses?(descriptor)
      path_for(descriptor).exist?
    end

    def import(descriptor)
      ensure_space
      begin
        git.clone(repository(descriptor), descriptor.identifier, branch: descriptor.branch, path: path, depth: 0)
      rescue ::Git::GitExecuteError => e
        warn(error: e, descriptor: descriptor, verbosity: [:error])
      end
    end

    def open_for(model)
      git.open(path_for(model), log: Logger.new(STDOUT))
    end

    def repository(descriptor)
      fork_account ? "#{descriptor.repository}".gsub(default_account, fork_account): descriptor.repository
    end

    def branch(descriptor)
      descriptor.branch
    end

    def default_account; 'v2Blueprints' ;end
    def fork_account
      # 'MarkRatjens'
      default_account
    end

    def git; ::Git ;end

  end
end
