FROM debian:stretch-slim
MAINTAINER BeN
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /var/cache/apt/archives/partial && touch /var/cache/apt/archives/lock && chmod 640 /var/cache/apt/archives/lock
RUN apt-get clean && apt-get update && apt-get -y upgrade

RUN apt-get install -y mariadb-server
RUN apt-get clean all

#adding files
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./conf/start.sh /root/start.sh
COPY ./conf/create_mariadb_admin_user.sh /root/create_mariadb_admin_user.sh
RUN chmod +x /root/*

# Add volumes
VOLUME  ["/var/lib/mysql"]

# Expose ports
EXPOSE 3306

# Run bootstrap
CMD ["/root/start.sh"]
