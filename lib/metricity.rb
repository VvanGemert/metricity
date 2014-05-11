require 'json'
require 'metricity/version'
require 'metricity/plugin'

# Metricity
module Metricity
  def self.init
    u1 = UDPSocket.new
    msg = { test: 'woof' }
    u1.send msg.to_json, 0, "127.0.0.1", 9888
    # Plugin.init
  end
end
