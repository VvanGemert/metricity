require 'socket'

module Metricity
  # Network
  module Network
    def self.gather(platform)
      if platform[:os] == :mac
        { ip: { internal: private_ip, external: public_ip }}
      elsif platform[:os] == :linux
      
      end
    end
    
    def self.private_ip
      Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.ip_address
    end
    
    def self.public_ip
      ip = `curl checkip.dyndns.org`
    end
  end
end
