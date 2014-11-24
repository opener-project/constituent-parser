require 'open3'
require 'slop'
require 'nokogiri'
require 'opener/constituent_parsers/base'
require 'opener/constituent_parsers/nl'
require 'opener/constituent_parsers/de'

require_relative 'constituent_parser/version'
require_relative 'constituent_parser/cli'

module Opener
  ##
  # Constituent parser for various languages such as English and German.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class ConstituentParser
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => [],
    }.freeze

    ##
    # @param [Hash] options
    # @see Opener::ConstituentParsers::Base#initialize
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input KAF document and returns a new KAF document as a
    # String.
    #
    # @param [String] input
    # @return [String]
    #
    def run(input)
      args     = options[:args].dup
      language = language(input)

      if language_constant_defined?(language)
        kernel = language_constant(language).new(:args => args)
      else
        kernel = ConstituentParsers::Base.new(
          :args     => args,
          :language => language
        )
      end

      return kernel.run(input)
    end

    protected

    ##
    # Returns `true` if the current language has a dedicated kernel class.
    #
    # @return [TrueClass|FalseClass]
    #
    def language_constant_defined?(language)
      return ConstituentParsers.const_defined?(language.upcase)
    end

    ##
    # @return [Class]
    #
    def language_constant(language)
      return ConstituentParsers.const_get(language.upcase)
    end

    ##
    # @return the language from the KAF
    #
    def language(input)
      document = Nokogiri::XML(input)
      language = document.at('KAF').attr('xml:lang')

      return language
    end
  end # ConstituentParser
end # Opener
