#location gitlap-ci/dockerfile
FROM 888016039450.dkr.ecr.us-east-2.amazonaws.com/apache-php:72

ARG dbname
ARG dbhost
ARG dbpass
ARG dbuser
ARG redis_host
ARG fdw_host



# things to support drush.
RUN yum install -y mysql which rsync && \
    yum clean all
RUN curl -L0 -o drush.phar https://github.com/drush-ops/drush/releases/download/8.3.0/drush.phar && \
  mv drush.phar /usr/local/bin/drush && \
  chmod +x /usr/local/bin/drush

RUN mkdir -p /opt/scripts/
COPY drush/exec-drush /opt/scripts
COPY drush/exec-drush-cmds /opt/scripts
COPY drush/prod-solr-index /opt/scripts
COPY drush/prod-cron /opt/scripts

# addcomposer installed tools to path.
ENV PATH=$PATH:/var/www/vendor/bin

# expose variable for web environment 
ENV MYSQL_DATABASE=$dbname
ENV MYSQL_USER=$dbuser
ENV MYSQL_PASSWORD=$dbpass
ENV MYSQL_HOST=$dbhost
ENV MYSQL_PORT=3306
ENV REDIS_HOST=$redis_host
ENV FWD_HOST=$fdw_host
ENV DOCROOT=/var/www/public
ENV PHP_MEMORY_LIMIT=1024M

# allow php settings to be customized
COPY ./gitlab-ci/etc/99-project-php-settings.ini /etc/opt/demi/php72/php.d/99-project-php-settings.ini
COPY ./current.env /etc/sysconfig/httpd

# bring the codebase in. note that CI with move this dockerfile,
# before executing it so paths should be relative to the repo root.
COPY . /var/www