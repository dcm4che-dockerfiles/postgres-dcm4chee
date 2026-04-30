FROM postgres:13.23

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
COPY bin /usr/bin/
