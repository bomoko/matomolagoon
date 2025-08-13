#!/bin/sh

if [ -d /app/config ] && [ ! "$(ls -A /app/config)" ]; then
    cp -a /seedfiles/config/. /app/config/
fi

# if [ -d /app/plugins ] && [ ! "$(ls -A /app/plugins)" ]; then
#     cp -a /seedfiles/plugins/. /app/plugins/
# fi

# now we fix permissions
# chown -R 1000:1000 /app/config /app/plugins /app/tmp