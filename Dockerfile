FROM tobig77/centos7-elixir:latest

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV PATH=$PATH:/usr/local/elixir/bin
ENV ERL_AFLAGS="-kernel shell_history enabled"

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum clean all
RUN yum -y install nodejs yarn
RUN npm install -g npm --prefix=/usr/local
RUN ln -s -f /usr/local/bin/npm /usr/bin/npm
RUN ln -s -f /usr/local/bin/yarn /usr/bin/yarn

RUN yum -y install inotify-tools make gcc

WORKDIR /opt/app
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

CMD /bin/bash
