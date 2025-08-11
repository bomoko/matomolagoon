FROM matomo:fpm-alpine AS matomolib
FROM uselagoon/php-8.2-cli

WORKDIR /app

# matomo's data is a volume, so we copy from the source location
COPY --from=matomolib /usr/src/matomo/ /app/

COPY --from=matomolib /usr/src/matomo/config /seedfiles/
COPY --from=matomolib /usr/src/matomo/plugins /seedfiles/

COPY ./.lagoon/entrypoints/copy_seed_files.sh /lagoon/entrypoints/100_seed_files.sh
