FROM postgres:13.14

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
COPY bin /usr/bin/
