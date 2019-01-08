FROM leochan007/ubuntu1804_base
LABEL MAINTAINER leo chan <leochan007@163.com>

ENV DEBIAN_FRONTEND noninteractive

ENV EOS_VER 1.5.1

WORKDIR /root

RUN wget https://github.com/eosio/eos/releases/download/v$EOS_VER/eosio_$EOS_VER-1-ubuntu-18.04_amd64.deb

RUN apt-get install -y ./eosio_$EOS_VER-1-ubuntu-18.04_amd64.deb

COPY config /root

COPY start.sh /root

RUN chmod a+x start.sh
