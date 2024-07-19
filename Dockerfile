FROM postgres:15.7

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
COPY bin /usr/bin/
