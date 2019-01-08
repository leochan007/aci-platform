FROM leochan007/nginx

LABEL MAINTAINER leo chan <leochan007@163.com>

ENV DEBIAN_FRONTEND noninteractive

COPY nginx.conf /etc/nginx/nginx.conf

COPY aci-frontend.conf /etc/nginx/conf.d/aci-frontend.conf

COPY dist /alphacar_browser

CMD nginx -g 'daemon off;'
