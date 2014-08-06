require 'metricity/version'
require 'metricity/plugin'
require 'metricity/pigeon'

# Metricity
module Metricity
  def self.init
    pigeon = Metricity::Pigeon.new
    pigeon.package(
      'time' => Time.now.utc.to_s,
      'type' => 'memory_usage',
      'objects' => { 'rails' => 50, 'delayed_job' => 100 })
    pigeon.fly!
  end
end
