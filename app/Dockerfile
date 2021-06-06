FROM phusion/passenger-ruby27:1.0.11

ENV PATH=/app/bin:${PATH}
ENV ANALYSIS_BIN="node /analysis-node/dist/index.js"

RUN DEBIAN_FRONTEND=noninteractive \
    # add repository for postgres packages: needs to match base ubuntu/debian dist
    curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" && \
    # add repository for up-to-date git packages
    add-apt-repository ppa:git-core/ppa && \
    # add package repos for node & yarn
    curl -sL -o nodejs.deb https://deb.nodesource.com/node_13.x/pool/main/n/nodejs/nodejs_13.8.0-1nodesource1_amd64.deb | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    # prep and do package installs/updates
    apt-get --quiet --yes update && \
    apt-get --quiet --yes --option=Dpkg::Options::=--force-confdef upgrade && \
    apt-get --quiet --yes --option=Dpkg::Options::=--force-confdef install \
      inotify-tools \
      cmake \
      git \
      libsodium23 \
      ./nodejs.deb \
      pkg-config \
      yarn \
      postgresql-client-9.6

RUN bash -lc 'ruby -v'
RUN bash -lc 'which ruby'
RUN bash -lc 'rvm install "ruby-2.7.2"' && \
    bash -lc 'rvm --default use ruby-2.7.2' && \
    gem update --system && \
    # cleanup apt packages/caches
    apt-get --quiet --yes autoremove && \
    apt-get --quiet --yes clean

WORKDIR /analysis
COPY analysis/package.json analysis/yarn.lock ./
RUN yarn install
COPY analysis/ ./
RUN yarn dist

WORKDIR /analysis-node
COPY analysis-node/package.json analysis-node/yarn.lock ./
RUN yarn install
COPY analysis-node/ ./
RUN bin/dist

WORKDIR /app
COPY --chown=app:app app/Gemfile* ./
RUN bundle install --jobs 4 --quiet

COPY --chown=app:app app/package.json ./
COPY --chown=app:app app/yarn.lock ./
RUN yarn --silent --non-interactive --pure-lockfile

COPY --chown=app:app app/ /app
