require 'json'
require 'socket'

# Metricity
module Metricity
  # Pigeon
  class Pigeon
    @package = {}
    
    def package(package)
      @package = package
    end

    def fly!
      udps = UDPSocket.new
      udps.send @package.to_json, 0, "127.0.0.1", 9888
    end
  end
end
