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
      address = Socket.ip_address_list.find { |intf| intf.ipv4_private? }
      address ? address.ip_address : 'unknown'
    end

    def self.public_ip
      ip = 'unknown'
      begin
        open('http://checkip.dyndns.org', read_timeout: 5) do |f|
          f.each_line { |line| ip = line.split('Address:')[1].split('<')[0] }
        end
        ip.strip!
      rescue
        ip
      end
    end
  end
end
