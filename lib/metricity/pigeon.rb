require 'json'
require 'socket'

# Metricity
module Metricity
  # Pigeon
  class Pigeon
    attr_writer :package

    def fly!
      tcps = TCPSocket.new '127.0.0.1', 9888
      tcps.send @package.to_json, 0
    end
  end
end
