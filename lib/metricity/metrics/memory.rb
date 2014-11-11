# Metricity
module Metricity
  # Plugin
  module Metric
    # Memory
    module Memory
      def self.run(platform)
        if platform[:os] == :mac
          mac_specific
        elsif platform[:os] == :linux
          linux_specific
        end
      end

      def self.linux_specific
        raw = `echo | top -bn1`
        raw = raw.split("\n")
        mem_usage = raw[3].split(' ')
        total = mem_usage[2]
        used = mem_usage[4]
        free = mem_usage[6]
        { total: to_mb(total), used: to_mb(used), free: to_mb(free) }
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
      
      def self.to_mb(val)
        (val.to_f / 1000).to_i
      end
    end
  end
end
