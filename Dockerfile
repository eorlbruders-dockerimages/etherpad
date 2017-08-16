FROM registry.eorlbruder.de/supervisord
MAINTAINER David Magnus Henriques <eorlbruder@magnus-henriques.de>

RUN pacman -Syyu --noconfirm --noprogressbar pkg-config git python && \
    pacman -Sc --noconfirm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
RUN . /root/.nvm/nvm.sh && nvm install 6.9.1

RUN mkdir /app
RUN git clone https://github.com/ether/etherpad-lite.git /app

ADD assets/etherpad.conf /etc/supervisor/conf.d/etherpad.conf

RUN . /root/.nvm/nvm.sh && /app/bin/installDeps.sh

RUN touch /mnt/settings.json
RUN rm /app/settings.json
RUN ln -s /mnt/settings.json /app/settings.json

CMD ["supervisord", "-n"]
