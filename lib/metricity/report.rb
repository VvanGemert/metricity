require 'metricity/pigeon'
require 'metricity/general/platform'
require 'metricity/general/network'
require 'awesome_print'

# Metricity
module Metricity
  # Report
  module Report
    def self.init
      metrics = require_metrics
      data = { system: {}, metrics: {} }
      platform = Metricity::Platform.determine
      data[:system][:platform] = platform
      data[:system][:network] = Metricity::Network.gather(platform)

      metrics.each do |metric|
        data[:metrics][metric.to_sym] =
          Kernel.const_get('Metricity::Metric::' + metric.capitalize)
            .run(platform)
      end

      ap data
    end

    private

    def self.require_metrics
      list = []
      Dir[File.dirname(__FILE__) + '/metrics/*.rb'].each do |file|
        list.push(file.split('/').last[0..-4])
        require file
      end
      list
    end
  end
end
