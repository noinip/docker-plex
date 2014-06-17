FROM ubuntu:14.04
MAINTAINER Eric Schultz <eric@startuperic.com>
#Thanks to Tim Haak <tim@haak.co.uk>
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8

RUN apt-get -q update
RUN apt-mark hold initscripts udev plymouth mountall
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes curl

RUN echo "deb http://shell.ninthgate.se/packages/debian squeeze main" > /etc/apt/sources.list.d/plexmediaserver.list

RUN curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -

RUN apt-get -q update
RUN apt-get install -qy --force-yes plexmediaserver

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
