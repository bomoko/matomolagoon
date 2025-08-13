FROM matomo:fpm-alpine AS matomolib
FROM uselagoon/php-8.2-cli

WORKDIR /app

# matomo's data is a volume, so we copy from the source location
COPY --from=matomolib /usr/src/matomo/ /app/

ENV MATOMO_PLUGIN_DIRS='/app/plugins/;plugins/:/app/plugins_persistent/;plugins_persistent/'
ENV MATOMO_PLUGIN_COPY_DIR='/app/plugins_persistent/'

RUN mkdir -p /seedfiles/plugins /app/plugins_persistent

COPY --from=matomolib /usr/src/matomo/config /seedfiles/config/
# COPY --from=matomolib /usr/src/matomo/plugins /seedfiles/plugins/
COPY --from=matomolib /usr/src/matomo/plugins /app/plugins/

RUN chown -R 1000:root /seedfiles/config /seedfiles/plugins /app


COPY ./.lagoon/entrypoints/copy_seed_files.sh /lagoon/entrypoints/100_seed_files.sh

COPY ./.env /app/.env

# we have to fix perms for 1000
RUN chown -R 1000:root /app/config /app/plugins /app/tmp /app/plugins_persistent
RUN chmod g+rw /app/config /app/plugins /app/tmp /app/plugins_persistent
