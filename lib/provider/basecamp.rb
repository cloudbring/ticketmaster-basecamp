module TicketMaster::Provider
  # This is the Basecamp Provider for ticketmaster
  module Basecamp
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Basecamp.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:basecamp, auth)
    end
    
    def authorize(auth = {})
      auth[:ssl] ||= false
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.domain.nil? or (auth.token.nil? and (auth.username.nil? and auth.password.nil?))
        raise "Please provide at least an domain and token or username and password)"
      end
      unless auth.token.nil?
        auth.username = auth.token
        auth.password = 'Basecamp lamo'
      end
      Kernel::Basecamp.establish_connection!(auth.domain, auth.username, auth.password, auth.ssl)
    end
    
  end
end


