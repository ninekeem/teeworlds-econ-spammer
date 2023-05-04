FROM alpine:latest
RUN apk add --no-cache netcat-openbsd tzdata
COPY *.sh /usr/local/bin/
ENTRYPOINT ["spammer.sh"]
