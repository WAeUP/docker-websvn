FROM alpine:3.7
MAINTAINER ulif
ARG SVN_UID=1000
ARG SVN_GID=1000

RUN apk --update add --no-cache \
    curl \
    shadow \
    ca-certificates \
    subversion \
    apache2 \
    apache2-utils \
    apache2-webdav \
    mod_dav_svn \
    php7 \
    php7-apache2 \
    php7-xml

# ensure, apache user can handle svn
RUN if [ "$SVN_UID" != "100" ] ; then usermod -u $SVN_UID apache && groupmod -g $SVN_GID apache ; fi

# install websvn
WORKDIR "/var/www"
RUN curl -L -o 2.5.tar.gz https://github.com/websvnphp/websvn/archive/2.5.tar.gz  &&  tar -xzf 2.5.tar.gz && mv websvn-2.5 websvn

COPY websvn.conf /etc/apache2/conf.d/websvn.conf
COPY config.php /var/www/websvn/include/config.php

RUN ln -s /var/www/modules /etc/apache2/modules
# only needed on alpine 3.7
RUN mkdir -p /run/apache2 && chown apache:apache /run/apache2

VOLUME ["/var/www/"]
VOLUME ["/etc/apache2/conf.d/"]
VOLUME ["/svn"]

EXPOSE 80

CMD /usr/sbin/httpd -D FOREGROUND
