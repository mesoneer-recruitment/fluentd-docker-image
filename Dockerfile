FROM fluent/fluentd:v1.9.1-1.0

# Following the official guidelines 
# https://github.com/fluent/fluentd-docker-image#3-customize-dockerfile-to-install-plugins-optional

LABEL maintainer="developers@ubitec.ch"
LABEL description="A customized version of official fluentd ot install plugins"
LABEL version="v1.9.1-1.0-v0.1.0"

USER root

ARG plugins="\
    fluent-plugin-elasticsearch \
    "

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update \
    --virtual .build-deps \
    build-base ruby-dev \
    && gem install ${plugins} \
    && gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent