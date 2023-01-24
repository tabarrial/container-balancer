#Choose Debian
FROM debian:latest

MAINTAINER DiouxX "github@diouxx.be"

#Don't ask questions during install
ENV DEBIAN_FRONTEND noninteractive

#Install apache2 and enable proxy mode
RUN apt update \
&& apt -y install \
apache2 \
nano

RUN a2enmod proxy \
&& a2enmod proxy_http \
&& a2enmod ssl \
&& a2enmod rewrite \
&& service apache2 stop

#Ports
EXPOSE 80 443

#Volumes
#VOLUME /opt/proxy-conf
COPY files/000-default.conf /etc/apache2/sites-available/

#Launch Apache2 on FOREGROUND
COPY files/apache-proxy-start.sh /opt/
RUN chmod +x /opt/apache-proxy-start.sh
ENTRYPOINT ["/opt/apache-proxy-start.sh"]
