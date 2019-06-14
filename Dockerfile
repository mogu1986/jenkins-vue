FROM harbor.top.mw/library/openresty:1.13.6.2-centos
MAINTAINER gaowei <gaowei@fengjinggroup.com>
ADD ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD ./dist /usr/local/openresty/nginx/html

#FROM node:lts-alpine as build-stage
#WORKDIR /app
#COPY package*.json ./
#RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
#RUN cnpm install
#COPY . .
#RUN npm run build
#
## production stage
#FROM harbor.top.mw/library/openresty:1.13.6.2-centos
#ADD ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
#COPY --from=build-stage /app/dist /usr/local/openrdocesty/nginx/html