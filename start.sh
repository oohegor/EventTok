#!/bin/sh
nginx -g "daemon off;" &
sleep 5
killall ngrok || true
ngrok http 80
