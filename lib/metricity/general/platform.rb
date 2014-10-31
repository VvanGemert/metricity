module Metricity
  # Platform
  module Platform
    def self.determine
      os = detect_os
      { os: os, version: version(os) }
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
        raw = `sw_vers | cut -d: -f2 | awk '{print $1;}'`
        output = raw.split("\n")
        output[1] + ' build: ' + output[2]
      elsif os == :linux
        raw = `lsb_release -a | cut -d: -f2 | tr -d '\t'`
        output = raw.split("\n")
        { distro: output[0], name: output[3],
          version: output[2], all: output[1] }
      end
    end
  end
end
