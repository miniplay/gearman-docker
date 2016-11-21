FROM centos:6.8
MAINTAINER Rafael de Elvira <rafa@minijuegos.com>

RUN yum -y install epel-release
RUN yum clean all
RUN yum -y update

## Stuff needed for gearman compilation
RUN yum -y install libevent-devel gcc-c++ boost-devel
RUN yum -y install gperftools-devel.x86_64 gperf.x86_64 gperftools-libs.x86_64 gperftools.x86_64
RUN yum -y install libuuid-devel.x86_64 libuuid.x86_64
RUN yum -y install wget

## Gearman compilation
WORKDIR /var/tmp/
RUN wget https://github.com/gearman/gearmand/releases/download/1.1.14/gearmand-1.1.14.tar.gz
RUN tar xvzf gearmand-1.1.14.tar.gz
WORKDIR /var/tmp/gearmand-1.1.14
RUN ./configure --prefix=/
RUN make
RUN make install
RUN adduser gearmand

## Create dir and copy startup script
RUN mkdir -p /opt/gearman/script
WORKDIR /opt/gearman
COPY ./script /opt/gearman/script
RUN chown -R gearmand /opt/gearman
RUN chmod -R 775 /opt/gearman

CMD ["/opt/gearman/script/run.sh"]
