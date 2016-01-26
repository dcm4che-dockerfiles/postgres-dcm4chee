FROM postgres:9.4

RUN mkdir /sql

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
