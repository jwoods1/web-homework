FROM elixir:1.11

RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs locales inotify-tools gcc g++ make \
    && rm -rf /var/cache/apt \
    && npm install -g yarn \
    && mix local.hex --force \
    && mix local.rebar --force \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen