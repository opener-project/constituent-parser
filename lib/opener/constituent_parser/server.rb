require 'sinatra/base'
require 'httpclient'
require 'opener/webservice'

module Opener
  class ConstituentParser
    ##
    # Constituent parser server powered by Sinatra.
    #
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor ConstituentParser
      accepted_params :input, :language
    end # Server
  end # ConstituentParser
end # Opener
