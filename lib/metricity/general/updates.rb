# apt-get upgrade -s |grep "Inst"| awk ' { print $2 } '| tr '\n' ' '

# apt-cache policy libxml2 | grep "Installed" | awk ' { print $2 } '
# apt-cache policy libxml2 | grep "Candidate" | awk ' { print $2 } '


# aptitude -F%p --disable-columns search ~U
# aptitude -q -F "%?p" --disable-columns search \~i
# apt-get -s dist-upgrade | awk '/^Inst/ { print $2 }'

# apt-cache policy *

# { apt-get --just-print upgrade 2>&1 | perl -ne 'if (/Inst\s([\w,\-,\d,\.,~,:,\+]+)\s\[([\w,\-,\d,\.,~,:,\+]+)\]\s\(([\w,\-,\d,\.,~,:,\+]+)\)? /i) {print "$1 (\e[1;34m$2\e[0m -> \e[1;32m$3\e[0m)\n"}';} | while read -r line; do echo -en "$line\n"; done;

# Metricity
module Metricity
  # SystemTime
  module Updates
    def self.gather(platform)
      if platform[:os] == :mac
        { :found => 'none' }
      elsif platform[:os] == :linux
        { :found => find_apt_updates }
      end
    end

    def self.find_apt_updates
      raw = `{ apt-get --just-print upgrade 2>&1 | perl -ne 'if (/Inst\s([\w,\-,\d,\.,~,:,\+]+)\s\[([\w,\-,\d,\.,~,:,\+]+)\]\s\(([\w,\-,\d,\.,~,:,\+]+)\)? /i) {print "$1 (\e[1;34m$2\e[0m -> \e[1;32m$3\e[0m)\n"}';} | while read -r line; do echo -en "$line\n"; done;`
      raw.split("\n")
    end
  end
end
