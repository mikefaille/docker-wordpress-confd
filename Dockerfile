FROM mikefaille/confd:latest
MAINTAINER Michaël Faille <michael@faille.pw>
#ADD supervisor-confd.conf /etc/supervisor/conf.d/confd.conf

# go get confd and prepare confd directories
#RUN rm -R /var/www && git clone --depth=1 https://github.com/WordPress/WordPress.git   && mkdir -p /etc/confd/{conf.d,templates}
RUN mkdir -p /etc/confd/{conf.d,templates}

RUN apt-get update -qy && apt-get install -qy unzip  git supervisor apache2 libapache2-mod-php5 php5-mysql php5-memcache php5-curl php5-imagick php5-gd  php-apc php5-memcache

RUN a2enmod rewrite && a2enmod expires && a2enmod headers

ADD /etc/httpd/security /etc/apache2/conf.d/security
#ADD /php.ini /etc/php5/apache2/php.ini
ADD /etc/httpd/apache_default /etc/apache2/sites-available/default

# Lauch apache from supervisor
ADD /supervisord-apache2.conf /etc/supervisor/conf.d/apache2.conf
ADD /start-apache2.sh /data/start-apache2.sh

# Add confd templates for Wordpress
ADD etc/confd/conf.d/wp-config.toml /etc/confd/conf.d/wp-config.toml
ADD etc/confd/templates/wp-config.tmpl /etc/confd/templates/wp-config.tmpl


# Wordpress config
# TODO check apache document root
RUN rm -R /var/www/
RUN git clone --depth=1 https://github.com/WordPress/WordPress.git /var/www
RUN chown www-data:www-data /var/www && chmod 755 /data/start-apache2.sh
#ADD /etc/wordpress/wp-config.php /data/app/wp-config.php

CMD ["/data/run.sh"]
