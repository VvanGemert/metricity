# Metricity
module Metricity
  # Plugin
  module Metric
    # System
    module Cpu
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
        cpu_usage = raw[2].split(' ')
        { user: cpu_usage[1], system: cpu_usage[3], idle: cpu_usage[7] }
      end

      def self.mac_specific
        raw = `echo | top -n1`
        raw = raw.split("\r")
        cpu_usage = raw[1].split(' ')
        { user: to_percentage(cpu_usage[7]),
          system: to_percentage(cpu_usage[9]),
          idle: to_percentage(cpu_usage[11]) }
      end

      def self.to_percentage(val)
        val.chomp.to_f.round
      end
    end
  end
end
