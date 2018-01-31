FROM tobig77/centos7-elixir:latest

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV NODE_VERSION v9.4.0
ENV NPM_VERSION 5.6.0
ENV YARN_VERSION 1.3.2


ENV PATH=$PATH:/usr/local/elixir/bin
ENV ERL_AFLAGS="-kernel shell_history enabled"

RUN yum -y install inotify-tools make gcc
RUN yum -y groupinstall "Development Tools"

RUN curl -sL https://rpm.nodesource.com/setup_9.x | bash -
RUN yum clean all
RUN yum -y install nodejs
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN yum -y install yarn

RUN [ "$(node --version)" == "$NODE_VERSION" ] || exit 1
RUN [ "$(npm --version)" == "$NPM_VERSION" ] || exit 1
RUN [ "$(yarn --version)" == "$YARN_VERSION" ] || exit 1

WORKDIR /opt/app
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
RUN mix local.hex --force
RUN mix local.rebar --force

CMD /bin/bash
