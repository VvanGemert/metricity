# Metricity
module Metricity
  # Plugin
  module Metric
    # Disk
    module Disk
      def self.run(platform)
        disks = {}
        raw = `df -P | grep /dev/`.split("\n")
        raw.each do |data|
          disk = data.split(' ')
          disks[disk[5]] = {
            filesystem: disk[0], mountpoint: disk[5],
            used: to_mb(disk[2]), available: to_mb(disk[3]),
            size: to_mb(disk[1]) }
        end
        disks
      end

      def self.to_mb(value)
        (value.to_f / 1024).to_i
      end
    end
  end
end
