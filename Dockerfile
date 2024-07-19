FROM postgres:11.22-bullseye

>>>>>>> cb044f0 ( Upgrade Postgres DB docker image to 16.3 dcm4che/dcm4chee-arc-light#4533)
COPY docker-entrypoint-initdb.d docker-entrypoint-initdb.d/
COPY sql sql/
COPY bin /usr/bin/
