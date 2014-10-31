# Metricity
module Metricity
  # Plugin
  module Metric
    # System
    module Memory
      def self.run
        puts 'Memory:'
        total_memory_usage_in_k = `ps -Ao rss=`.split.map(&:to_i).reduce(&:+)
        puts total_memory_usage_in_k
      end
    end
  end
end
