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
        raw = `top -bn1`
        raw = raw.split("\n")
        cpu_usage = raw[2].split(' ')
        { user: cpu_usage[1].to_f.round,
          system: cpu_usage[3].to_f.round,
          idle: cpu_usage[7].to_f.round }
      end

      def self.mac_specific
        raw = `top -n 1 -l 1`
        raw = raw.split("\n")
        cpu_usage = raw[3].split(' ')
        { user: to_percentage(cpu_usage[2]),
          system: to_percentage(cpu_usage[4]),
          idle: to_percentage(cpu_usage[6]) }
      end

      def self.to_percentage(val)
        val.chomp.to_f.round
      end
    end
  end
end
