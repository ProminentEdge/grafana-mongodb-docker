FROM node:lts-alpine AS node

FROM grafana/grafana-oss

USER root

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

ADD ./custom-run.sh /custom-run.sh

# Add SSL certificates (Replace with your own cert and key)
COPY ./ssl/grafana.crt /etc/ssl/certs/grafana.crt
COPY ./ssl/grafana.key /etc/ssl/private/grafana.key

RUN apk update \
    && apk upgrade \
    && apk add --no-cache git openssl \
    && git clone https://github.com/SiemaApplications-attic/mongodb-grafana $GF_PATHS_PLUGINS/mongodb-grafana \
    && rm -rf $GF_PATHS_PLUGINS/mongodb-grafana/.git \
    && npm install --silent --prefix $GF_PATHS_PLUGINS/mongodb-grafana \
    && npm cache clean --force --prefix $GF_PATHS_PLUGINS/mongodb-grafana \
    && npm install pm2 -g \
    && apk del --no-cache git \
    && chmod +x /custom-run.sh \
    && sed -i 's/;allow_loading_unsigned_plugins =.*/allow_loading_unsigned_plugins = grafana-mongodb-opensource-datasource/g' $GF_PATHS_CONFIG \
    && sed -i 's/;angular_support_enabled =.*/angular_support_enabled = true/g' $GF_PATHS_CONFIG \
    && sed -i 's/;protocol =.*/protocol = https/g' $GF_PATHS_CONFIG \
    && sed -i 's/;cert_file =.*/cert_file = \/etc\/ssl\/certs\/grafana.crt/g' $GF_PATHS_CONFIG \
    && sed -i 's/;cert_key =.*/cert_key = \/etc\/ssl\/private\/grafana.key/g' $GF_PATHS_CONFIG

ENTRYPOINT ["/custom-run.sh"]
