require 'metricity/version'
require 'metricity/plugin'
require 'metricity/pigeon'

# Metricity
module Metricity
  def self.init
    pigeon = Metricity::Pigeon.new
    pigeon.package({ test: 'woof' })
    pigeon.fly!
  end
end
