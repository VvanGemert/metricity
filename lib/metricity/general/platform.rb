module Metricity
  # Platform
  module Platform
    def self.determine
      os = detect_os
      { os: os }.merge(version(os))
    end

    def self.detect_os
      if /darwin/ =~ RUBY_PLATFORM
        :mac
      elsif /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM
        :win
      else
        :linux
      end
    end

    def self.version(os)
      if os == :mac
        mac_specific
      elsif os == :linux
        linux_specific
      end
    end

    def self.mac_specific
      raw = `sw_vers | cut -d: -f2 | awk '{print $1;}'`
      output = raw.split("\n")
      { version: output[1], build: output[2] }
    end

    def self.linux_specific
      raw = `lsb_release -a | cut -d: -f2 | tr -d '\t'`
      output = raw.split("\n")
      base = 'deb'
      base = 'rpm' if %w(redhat fedora centos).include?(output[0])
      { distro: output[0], name: output[3], version: output[2],
        all: output[1], base: base }
    end
  end
end
