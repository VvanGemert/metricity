require 'metricity/pigeon'
require 'metricity/general/platform'
require 'metricity/general/network'

# Metricity
module Metricity
  # Report
  module Report
    def self.init
      require_metrics
      data = { system: {} }
      platform = Metricity::Platform.determine
      data[:system][:platform] = platform
      data[:system][:network] = Metricity::Network.gather(platform)

      p data

      # p machine_info
      # Metricity::Metric::Cpu.run
      # Metricity::Metric::Memory.run
    end

    private

    def self.require_metrics
      Dir[File.dirname(__FILE__) + '/metrics/*.rb'].each do |file|
        require file
      end
    end
  end
end
