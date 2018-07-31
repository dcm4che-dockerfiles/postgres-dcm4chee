FROM postgres:10.4

COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
