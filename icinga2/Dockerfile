FROM jordan/icinga2:2.6.1
MAINTAINER apkawa <apkawa@gmail.com>

# FIX ISSUE check_nrpe
RUN apt-get -qq update \
     && apt-get -qqy install --no-install-recommends \
           nagios-nrpe-plugin \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*