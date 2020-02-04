require_relative 'model'

module Spaces
  class Descriptor < ::Spaces::Model

    attr_accessor :value,
      :identifier,
      :protocol,
      :branch,
      :extraction,
      :extracted_path,
      :destination_path

    def initialize(struct = nil)
      if struct
        self.value = struct.value
        self.identifier = struct.identifier
        self.protocol = struct.protocol
        self.branch = struct.branch
        self.extraction = struct.extraction
        self.extracted_path = struct.extracted_path
        self.destination_path = [home_path, struct.destination_path].compact.join('/')
      end
    end

    def identifier
      @identifier ||= value&.split('/').last.split('.').first
    end

    def branch
      @branch ||= 'master'
    end

    def protocol
      @protocol ||= extension
    end

    def extraction
      @extraction ||= extension
    end

    def extracted_path
      @extracted_path ||= identifier
    end

    def home_path
      '/home/app'
    end

    def basename
      File.basename(value)
    end

    def extension
      value&.split('.')&.last
    end

  end
end