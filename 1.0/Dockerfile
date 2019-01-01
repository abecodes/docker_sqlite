FROM alpine:3.7

# Envs
ENV MAINTAINED_VERSION 1.0
ENV SQLITE_VERSION 3.26.0-r3

# Metadata
LABEL maintainer="me@abe.codes" \
    version="${MAINTAINED_VERSION}" \
    sqlite.version="${SQLITE_VERSION}" \
    description="A simple docker image for SQLite with customizable DBs"

RUN apk add --no-cache sqlite && \
    mkdir /db

COPY ./docker-entrypoint.sh /usr/local/bin

VOLUME [ "/db" ]

ENTRYPOINT ["docker-entrypoint.sh"]
