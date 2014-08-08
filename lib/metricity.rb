require 'metricity/version'
require 'metricity/daemon'
require 'metricity/plugin'
require 'metricity/pigeon'

# Metricity
module Metricity
  def self.init
    pigeon = Metricity::Pigeon.new
    pigeon.package = {
      'time' => Time.now.utc.to_s,
      'metrics' => {
        'memory' => {
          'rails' => rand(10), 'delayed_job' => rand(50) } } }
    pigeon.fly!
  end
end
