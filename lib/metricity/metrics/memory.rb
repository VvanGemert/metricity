# Metricity
module Metricity
  # Plugin
  module Metric
    # System
    module Memory
      def self.run(platform)
        mac_specific
      end

      def self.mac_specific
        raw = `echo | top -n1`
        raw = raw.split("\r")
        mem_usage = raw[2].split(' ')
        total = mem_usage[10].chop!
        used = mem_usage[3].chop!
        free = total.to_i - used.to_i
        { total: total.to_i, used: used.to_i, free: free }
      end
    end
  end
end
