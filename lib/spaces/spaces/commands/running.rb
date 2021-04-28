module Spaces
  module Commands
    class Running < ::Spaces::Model

      def result; struct[:result] ;end
      def errors; struct[:errors] ;end
      def payload; struct.to_h.without(:input) ;end

      def run
        tap do
          _result
        rescue ::Spaces::Errors::SpacesError => e
          struct.errors = e.diagnostics
        end
      end

      def has_run?; !payload.empty? ;end
      def success?; has_run? && errors.nil? ;end
      def fail?; has_run? && !success? ;end

      def space
        universe.send(space_identifier)
      rescue TypeError
        raise ::Spaces::Errors::MissingInput, {input: input}
      end

      def space_identifier
        input[:space]
      end

      def initialize(**input)
        self.struct = OpenStruct.new(input: input.symbolize_keys)
      end

      protected

      def _result
        struct.result =
        if c = commit
          c
        else
          assembly
        end
      rescue NoMethodError
        raise ::Spaces::Errors::MissingInput, {input: input}
      end

      def assembly ;end
      def commit ;end

    end
  end
end
