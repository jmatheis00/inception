FROM alpine:3.16
RUN	apk update && apk upgrade && apk add --no-cache nginx
#Docker container listens on port 443 (HTTPS traffic)
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]