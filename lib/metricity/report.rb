require 'metricity/pigeon'
require 'metricity/general/platform'
require 'metricity/general/machine'

# Metricity
module Metricity
  # Report
  module Report
    def self.init
      require_metrics
      platform = Metricity::Platform.determine
      p platform
      # machine_info = Metricity::Machine.info(os)
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
