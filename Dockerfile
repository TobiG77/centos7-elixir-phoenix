FROM tobig77/centos7-elixir:latest

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV PATH=$PATH:/usr/local/elixir/bin
ENV ERL_AFLAGS="-kernel shell_history enabled"

RUN yum -y install inotify-tools make gcc

RUN curl -sL https://rpm.nodesource.com/setup_9.x | bash -
RUN yum clean all
RUN yum -y install nodejs
RUN npm install -g npm --prefix=/usr/local
RUN ln -s -f /usr/local/bin/npm /usr/bin/npm

RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN yum -y install yarn

WORKDIR /opt/app
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
RUN mix local.hex --force
RUN mix local.rebar --force

CMD /bin/bash
