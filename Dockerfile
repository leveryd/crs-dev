FROM owasp/modsecurity-crs:3.3.5-nginx-alpine-202401080101

RUN apk add vim bash
COPY ./conf/setup.conf /etc/nginx/templates/modsecurity.d/setup.conf.template
COPY ./lua/inspect.lua /usr/local/share/lua/5.3/inspect.lua
COPY ./lua/debug.lua /tmp/debug.lua

# 快捷键
COPY ./conf/alias.sh /root/.bashrc