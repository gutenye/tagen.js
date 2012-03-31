module Rake # ::Pipeline::FileWrapper
  class Pipeline
    class FileWrapper
      def readline
        if "".respond_to?(:encode)
          @file ||= File.open(fullpath, :encoding => encoding)
        else
          @file ||= File.open(fullpath)
        end

        line = @file.readline

        if "".respond_to?(:encode) && !line.valid_encoding?
          raise EncodingError, "The file at the path #{fullpath} is not valid UTF-8. Please save it again as UTF-8."
        end

        line
      end
    end
  end
end

module Neuter

  DEBUG = false

  class SpadeWrapper < Rake::Pipeline::FileWrapper
    
    REQUIRE_RE = %r{^\s*require\(['"]([^'"]*)['"]\);?\s*}

    # Keep track of required files
    @@required = []

    def read
      source = super

      # Replace all requires with emptiness, and accumulate dependency sources
      prepend = ''
      source.gsub! REQUIRE_RE do |m|
        req = $1

        # Find a reason to fail
        reason = @@required.include?(req) ? 'Already required' : false
        reason ||= is_external_req(req) ? "External package  - #{req}" : false

        if reason
          puts "DEBUG Skipped #{req} required in #{path} (#{reason})" if DEBUG
        else
          @@required << req
          req_file = File.join("#{req}.js")
          prepend = prepend + self.class.new(root, req_file, encoding).read
          puts "DEBUG Required #{req_file} as #{req} in #{path}" if DEBUG
        end
        ''
      end

      source = "(function() {\n#{source}\n})();\n\n"
      "#{prepend}#{source}"
    end

    protected

    #  not require "./foo"
    def is_external_req(req)
      not req.match(%~^\./~)
    end
  end

  module Filters

    class NeuterFilter < Rake::Pipeline::ConcatFilter

      # Allows selective concat by passing packages array (or all if nil)
      def initialize(string=nil, &block)
        @file_wrapper_class = SpadeWrapper
        super(string, &block)
      end

      def generate_output(inputs, output)
        inputs.each do |input|
          spade = SpadeWrapper.new(input.root, input.path, input.encoding)
          p "Neutering #{input.path} into #{output.path}" if DEBUG
          output.write spade.read          
        end
      end
    end

    class SelectFilter < Rake::Pipeline::ConcatFilter

      # Allows selective concat by passing packages array (or all if nil)
      def initialize(string=nil, &block)
        super(string, &block)
      end

      def generate_output(inputs, output)
        inputs.each do |input|
          next unless @packages.include?(input.path)
          output.write input.read
        end
      end
    end
  end

  module Helpers
    def neuter(*args, &block)
      filter(Neuter::Filters::NeuterFilter, *args, &block)
    end

    def select(*args, &block)
      filter(Neuter::Filters::SelectFilter, *args, &block)
    end
  end
end

Rake::Pipeline::DSL::PipelineDSL.send(:include, Neuter::Helpers)
