FROM golang:1.12.5-alpine3.9

RUN apk update && apk add curl

COPY build/bin /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint"]

#USER ${USER_UID}
