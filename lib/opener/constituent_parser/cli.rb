module Opener
  class ConstituentParser
    ##
    # CLI wrapper around {Opener::ConstituentParser} using Slop.
    #
    # @!attribute [r] parser
    #  @return [Slop]
    #
    class CLI
      attr_reader :parser

      def initialize
        @parser = configure_slop
      end

      ##
      # @param [Array] argv
      #
      def run(argv = ARGV)
        parser.parse(argv)
      end

      ##
      # @return [Slop]
      #
      def configure_slop
        return Slop.new(:strict => false, :indent => 2, :help => true) do
          banner 'Usage: constituent-parser [OPTIONS]'

          separator <<-EOF.chomp

About:

    Constituent parser for various languages such as English and Dutch. This
    command reads input from STDIN.

Example:

    cat some_file.kaf | constituent-parser
          EOF

          separator "\nOptions:\n"

          on :v, :version, 'Shows the current version' do
            abort "constituent-parser v#{VERSION} on #{RUBY_DESCRIPTION}"
          end

          on :l=, :language=, 'Sets a specific language to use', :as => String

          run do |opts, args|
            parser = ConstituentParser.new(
              :args     => args,
              :language => opts[:language]
            )

            input = STDIN.tty? ? nil : STDIN.read

            puts parser.run(input)
          end
        end
      end
    end # CLI
  end # ConstituentParser
end # Opener
