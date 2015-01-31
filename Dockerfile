# Set the base image to debian
FROM debian:jessie

# File Author / Maintainer
MAINTAINER William Jones <billy@freshjones.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm

# Update the repository sources list
RUN apt-get update && \
    apt-get install -y \
    pwgen \
    mysql-server

#add myconf file
ADD mysql/my.cnf /etc/mysql/conf.d/my.cnf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

#install scripts
ADD scripts/ /scripts/

#run install script
RUN chmod +x /scripts/*.sh

#run install db script
RUN /scripts/mysql_init.sh

# clean apt cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/mysql"]

#expose port 3306
EXPOSE 3306

CMD ["/usr/sbin/mysqld"]
