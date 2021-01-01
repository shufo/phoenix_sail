FROM elixir:1.11

WORKDIR /var/www/html

ARG WWWGROUP

# elixir expects utf8.
ENV LANG=C.UTF-8
ENV MIX_HOME=/.mix

RUN apt-get update \ 
    && apt-get install -y gosu curl ca-certificates zip unzip git supervisor inotify-tools \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN groupadd --force -g $WWWGROUP sail
RUN useradd -ms /bin/bash --no-user-group -g $WWWGROUP -u 1337 sail

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info


COPY start-container /usr/local/bin/start-container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /usr/local/bin/start-container

EXPOSE 4000

ENTRYPOINT ["start-container"]
