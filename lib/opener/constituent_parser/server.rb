require 'sinatra/base'
require 'httpclient'

module Opener
  class ConstituentParser
    ##
    # Constituent parser server powered by Sinatra.
    #
    class Server < Sinatra::Base
      configure do
        enable :logging
      end

      configure :development do
        set :raise_errors, true
        set :dump_errors, true
      end

      helpers do
        def webservice_path
          (request.script_name + "/").gsub(/\/\//,'/')
        end
      end

      ##
      # Provides a page where you see a textfield and you can post stuff
      #
      get '/' do
        erb :index
      end

      ##
      # Parses the constituent of a KAF document.
      #
      # @param [Hash] params The POST parameters.
      #
      # @option params [String] :text The text to be POS tagged.
      # @option params [Array<String>] :callbacks A collection of callback URLs
      #  that act as a chain. The results are posted to the first URL which is
      #  then shifted of the list.
      # @option params [String] :error_callback Callback URL to send errors to
      #  when using the asynchronous setup.
      #  server.
      #
      post '/' do
        if !params[:text] or params[:text].strip.empty?
          logger.error('Failed to process the request: no text specified')

          halt(400, 'No text specified')
        end

        callbacks = extract_callbacks(params[:callbacks])

        if callbacks.empty?
          process_sync
        else
          process_async(callbacks)
        end
      end

      private

      ##
      # Processes the request synchronously.
      #
      def process_sync
        output = parse_constituent(params[:text], params[:language])

        content_type('text/plain')

        body(output)
      end

      ##
      # Processes the request asynchronously.
      #
      # @param [Array] callbacks The callback URLs to use.
      #
      def process_async(callbacks)
        Thread.new do
          parse_constituent_async(
            params[:text],
            params[:language],
            callbacks,
            params[:error_callback]
          )
        end

        status(202)
      end

      ##
      # @param [String] text The text to be analyzed.
      # @param [String] language
      # @return [String]
      # @raise RuntimeError Raised when the process failed.
      #
      def parse_constituent(text, language)
        parser = ConstituentParser.new(:language => language)

        output, error, status = parser.run(text)

        raise(error) unless status.success?

        return output
      end

      ##
      # Gives tags to the tokenized text and submits it to a callback URL.
      #
      # @param [String] text
      # @param [String] language
      # @param [Array] callbacks
      # @param [String] error_callback
      #
      def parse_constituent_async(text, language, callbacks, error_callback = nil)
        begin
          output = parse_constituent(text, language)
        rescue => error
          logger.error("Failed to process the text: #{error.message}")

          submit_error(error_callback, error.message) if error_callback

          return
        end

        url = callbacks.shift

        logger.info("Submitting results to #{url}")
        logger.info("Using callback URLs: #{callbacks.join(', ')}")

        begin
          process_callback(url, output, callbacks)
        rescue => error
          logger.error("Failed to submit the results: #{error.inspect}")

          submit_error(error_callback, error.message) if error_callback
        end
      end

      ##
      # @param [String] url
      # @param [String] text
      # @param [Array] callbacks
      #
      def process_callback(url, text, callbacks)
        HTTPClient.post(
          url,
          :body => {:text => text, :'callbacks[]' => callbacks}
        )
      end

      ##
      # @param [String] url
      # @param [String] message
      #
      def submit_error(url, message)
        HTTPClient.post(url, :body => {:error => message})
      end

      ##
      # Returns an Array containing the callback URLs, ignoring empty values.
      #
      # @param [Array|String] input
      # @return [Array]
      #
      def extract_callbacks(input)
        callbacks = input.compact.reject(&:empty?)

        return callbacks
      end
    end # Server
  end # ConstituentParser
end # Opener
