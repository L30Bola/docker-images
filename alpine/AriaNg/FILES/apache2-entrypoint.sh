#!/usr/bin/env sh

rm -f "${HTTPD_PID}"/httpd.pid
exec httpd -DFOREGROUND
