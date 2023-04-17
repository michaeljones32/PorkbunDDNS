FROM alpine:latest

COPY ./porkbun.sh .

RUN apk add --no-cache --upgrade bash curl

ENTRYPOINT [ "bash", "porkbun.sh" ]