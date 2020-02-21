FROM postgres:12.2

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
COPY bin /usr/bin/
