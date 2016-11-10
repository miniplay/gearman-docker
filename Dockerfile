FROM centos:6.8
MAINTAINER Rafael de Elvira <rafa@minijuegos.com>

RUN yum -y install epel-release
RUN yum clean all
RUN yum -y update
RUN yum -y install gearmand.x86_64 libgearman.x86_64 libgearman-devel.x86_64

RUN mkdir -p /opt/gearman/script
WORKDIR /opt/gearman
COPY ./script /opt/gearman/script
RUN chown -R gearmand /opt/gearman
RUN chmod -R 775 /opt/gearman

CMD ["/opt/gearman/script/run.sh"]
