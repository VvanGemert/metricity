
# apt-get upgrade -s |grep "Inst"| awk ' { print $2 } '| tr '\n' ' '

# apt-cache policy libxml2 | grep "Installed" | awk ' { print $2 } '
# apt-cache policy libxml2 | grep "Candidate" | awk ' { print $2 } '

# apt-cache policy *
