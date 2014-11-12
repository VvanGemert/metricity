require 'metricity/pigeon'
require 'metricity/general/platform'
require 'metricity/general/network'
require 'metricity/general/system_time'
require 'awesome_print'

# Metricity
module Metricity
  # Report
  module Report
    def self.init
      data = { system: {}, metrics: {} }
      platform = Metricity::Platform.determine
      data[:system][:platform] = platform
      data[:system][:network] = Metricity::Network.gather(platform)
      data[:system][:time] = Metricity::SystemTime.gather(platform)
      data[:metrics] = handle_metrics(platform)
      ap data
    end

    private

    def self.handle_metrics(platform)
      data = {}
      metrics = require_metrics
      metrics.each do |metric|
        data[metric.to_sym] =
          get_module('Metricity::Metric::' + metric.capitalize)
            .run(platform)
      end
      data
    end

    def self.get_module(str)
      str.split('::').reduce(Object) do |mod, class_name|
        mod.const_get(class_name)
      end
    end

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
