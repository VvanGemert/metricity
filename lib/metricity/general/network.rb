require 'socket'
require 'open-uri'

module Metricity
  # Network
  module Network
    def self.gather(platform)
      { ip: { internal: private_ip, external: public_ip },
        hostname: hostname }
    end

    def self.hostname
      Socket.gethostname
    end

    def self.private_ip
      Socket.ip_address_list.find { |intf| intf.ipv4_private? }.ip_address
    end

    def self.public_ip
      ip = 'unknown'
      open('http://checkip.dyndns.org') do |f|
        f.each_line { |line| ip = line.split('Address:')[1].split('<')[0] }
      end
      ip.strip!
    end
  end
end
