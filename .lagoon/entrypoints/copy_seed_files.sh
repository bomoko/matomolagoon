#!/bin/sh

if [ -d /app/config ] && [ ! "$(ls -A /app/config)" ]; then
    cp -a /seedfiles/config/. /app/config/
fi