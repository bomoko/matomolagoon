ARG CLI_IMAGE
FROM ${CLI_IMAGE} AS cli

FROM uselagoon/php-8.2-fpm
WORKDIR /app

COPY --from=cli /app/ /app/

ENV MATOMO_PLUGIN_DIRS='/app/plugins,/app/plugins_baseimage'

# we have to fix perms for 1000
RUN chown -R 1000:1000 /app/config /app/plugins /app/tmp