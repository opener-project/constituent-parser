require 'open3'
require 'optparse'
require 'opener/constituent_parsers/base'

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
    # Returns the default language to use.
    #
    # @return [String]
    #
    DEFAULT_LANGUAGE = 'en'.freeze

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args     => [],
      :language => DEFAULT_LANGUAGE
    }.freeze

    ##
    # @param [Hash] options
    # @see Opener::ConstituentParsers::Base#initialize
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input and returns an array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input
    # @return [Array]
    #
    def run(input)
      args = options[:args].dup

      if language_constant_defined?
        kernel = language_constant.new(:args => args)
      else
        kernel = ConstituentParsers::Base.new(
          :args     => args,
          :language => options[:language]
        )
      end

      return kernel.run(input)
    end

    ##
    # @return [String]
    #
    def output_type
      return 'text/plain'
    end

    protected


    ##
    # Returns `true` if the current language has a dedicated kernel class.
    #
    # @return [TrueClass|FalseClass]
    #
    def language_constant_defined?
      return ConstituentParsers.const_defined?(language_constant_name)
    end

    ##
    # @return [String]
    #
    def language_constant_name
      return options[:language].upcase
    end

    ##
    # @return [Class]
    #
    def language_constant
      return ConstituentParsers.const_get(language_constant_name)
    end
  end # ConstituentParser
end # Opener
