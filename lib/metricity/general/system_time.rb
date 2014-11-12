# Metricity
module Metricity
  # SystemTime
  module SystemTime
    def self.gather(platform)
      { date: Time.now.to_s, date_utc: Time.now.utc.to_s, days_uptime: uptime }
    end

    def self.uptime
      `uptime | awk {'print$3'}`.chomp.to_i
    end
  end
end
