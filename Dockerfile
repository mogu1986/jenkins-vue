FROM harbor.top.mw/library/openresty:1.13.6.2-centos
MAINTAINER gaowei <gaowei@fengjinggroup.com>
ADD ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD ./dist /usr/local/openresty/nginx/html