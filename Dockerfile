FROM node:alpine
MAINTAINER David Magnus Henriques <eorlbruder@magnus-henriques.de>

RUN apk add --update git
RUN mkdir -p /opt/etherpad-lite
RUN git clone https://github.com/ether/etherpad-lite.git /opt/etherpad-lite

WORKDIR /opt/etherpad-lite
RUN ./bin/installDeps.sh

RUN cp ./settings.json /mnt/settings.json
RUN rm ./settings.json
RUN ln -s /mnt/settings.json ./settings.json

RUN rm -rf /var/cache/apk/*

CMD ["/opt/etherpad-lite/bin/run.sh"]
