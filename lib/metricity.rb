require 'metricity/version'
require 'metricity/daemon'
require 'metricity/report'

# Metricity
module Metricity
  def self.init
    Metricity::Report.init
  end
end
