require 'opener/webservice'

module Opener
  class ConstituentParser
    ##
    # Constituent parser server powered by Sinatra.
    #
    class Server < Webservice::Server
      set :views, File.expand_path('../views', __FILE__)

      self.text_processor  = ConstituentParser
      self.accepted_params = [:input, :language]
    end # Server
  end # ConstituentParser
end # Opener
