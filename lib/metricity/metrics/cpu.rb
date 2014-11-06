# Metricity
module Metricity
  # Plugin
  module Metric
    # System
    module Cpu
      def self.run(platform)
        if platform[:os] == :mac

        elsif platform[:os] == :linux
          puts 'CPU:'
          # output = `cat /proc/stat 2>&1`
          if $CHILD_STATUS && !$CHILD_STATUS.success?
            output = `sar 1 2>&1`
            puts output
          end
        end
      end
    end
  end
end
