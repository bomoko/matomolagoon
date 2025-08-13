FROM matomo:fpm-alpine AS matomolib
FROM uselagoon/php-8.2-cli

WORKDIR /app

# matomo's data is a volume, so we copy from the source location
COPY --from=matomolib /usr/src/matomo/ /app/

ENV MATOMO_PLUGIN_DIRS='/app/plugins;plugins/:/app/plugins_baseimage;plugins_baseimage/'

RUN mkdir -p /seedfiles/plugins

COPY --from=matomolib /usr/src/matomo/config /seedfiles/config/
# COPY --from=matomolib /usr/src/matomo/plugins /seedfiles/plugins/
COPY --from=matomolib /usr/src/matomo/plugins /app/plugins_baseimage/

RUN chown -R 1000:1000 /seedfiles/config /seedfiles/plugins /app


COPY ./.lagoon/entrypoints/copy_seed_files.sh /lagoon/entrypoints/100_seed_files.sh

COPY ./.env /app/.env
