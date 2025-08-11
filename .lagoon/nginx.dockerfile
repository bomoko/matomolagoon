ARG CLI_IMAGE
FROM ${CLI_IMAGE} AS cli


FROM uselagoon/nginx

COPY .lagoon/matomo_nginx.conf /etc/nginx/conf.d/app.conf
RUN fix-permissions /etc/nginx/conf.d/app.conf

COPY --from=cli /app/ /app/
