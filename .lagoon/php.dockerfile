ARG CLI_IMAGE
FROM ${CLI_IMAGE} AS cli

FROM uselagoon/php-8.2-fpm
WORKDIR /app

COPY --from=cli /app/ /app/

ENV MATOMO_PLUGIN_DIRS='/app/plugins/;plugins/:/app/plugins_persistent/;plugins_persistent/'
ENV MATOMO_PLUGIN_COPY_DIR='/app/plugins_persistent/'

RUN mkdir -p /seedfiles/plugins /app/plugins_persistent

COPY ./.lagoon/entrypoints/copy_seed_files.sh /lagoon/entrypoints/100_seed_files.sh

# we have to fix perms for 1000
RUN chown -R 1000:root /app/config /app/plugins /app/tmp /app/plugins_persistent