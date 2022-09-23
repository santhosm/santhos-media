FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia
RUN apt-get update -y &&  apt-get upgrade -y \
    && apt-get install -y apache2 mariadb-server php php-mysql libapache2-mod-php php-xml php-mbstring \
    && apt-get install -y php-apcu php-intl imagemagick inkscape php-gd php-cli php-curl php-bcmath git
COPY ./mediawiki-1.38.2.tar.gz /mediawiki-1.38.2.tar.gz
COPY ./starter.sh /starter.sh  
RUN tar -xvzf /mediawiki-1.38.2.tar.gz \
    && mkdir /var/lib/mediawiki \
    && mv mediawiki-*/* /var/lib/mediawiki \
    && ln -s /var/lib/mediawiki /var/www/html/mediawiki
ENTRYPOINT ["/bin/sh", "/starter.sh"] 