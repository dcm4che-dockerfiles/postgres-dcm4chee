This docker image provides PostgreSQL initalized for the DICOM Archive
[dcm4chee-arc-light](https://github.com/dcm4che/dcm4chee-arc-light/wiki).
It extends the [official postgres image](https://hub.docker.com/_/postgres/).

# How to use this image

## start a postgres instance

```console
$ docker run --name mypostgres \
             -p 15432:5432 \
             -e POSTGRES_DB=pacsdb \
             -e POSTGRES_USER=pacs \
             -e POSTGRES_PASSWORD=pacsword \
             -v /var/local/mypacs/db:/var/lib/postgresql/data \
             -d dcm4che/postgres-dcm4chee
```
## connect to it from the DICOM Archive application

```console
$ docker run --link mypostgres:db ... -d dcm4che/dcm4chee-arc-psql
```

## Environment Variables

This image does not define additional environment variables to those inherited from the PostgreSQL image. But in opposite to the base image, they are required - except `PGDATA` - to be specified, because the DICOM Archive application relies on their provision.

### `POSTGRES_PASSWORD`

This environment variable sets the superuser password for PostgreSQL. In the above example, it is being set to "pacsword".

### `POSTGRES_USER`

This environment variable is used in conjunction with `POSTGRES_PASSWORD` to set a user and its password. This variable will create the specified user with superuser power.

### `POSTGRES_DB`

This environment variable defines the name for the default database that is created when the image is first started.

### `PGDATA`

This optional environment variable can be used to define another location - like a subdirectory - for the database files. The default is `/var/lib/postgresql/data`, but if the data volume you're using is a fs mountpoint (like with GCE persistent disks), Postgres `initdb` recommends a subdirectory (for example `/var/lib/postgresql/data/pgdata` ) be created to contain the data.

## Setup Master/Slave Replication

1. Start a container with Postgres acting as 'master' DB:

    ```console
    $ docker run --name mypostgres-master \
                 -p 15432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacsword \
                 -v /var/local/mypacs/db:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee
    ```
2. Allow all hosts to replicate with this 'master' DB:

    ```console
    $ echo 'host replication replicator 0.0.0.0/0 trust' >> /var/local/mypacs/db/pg_hba.conf
    $ cat << EOF >> /var/local/mypacs/db/postgresql.conf
    wal_level = hot_standby
    checkpoint_segments = 8
    max_wal_senders = 3
    wal_keep_segments = 8
    hot_standby = on
    EOF
    ```
3. Restart the container:

    ```console
    $ docker restart mypostgres-master
    ```
4. Create a user for replication:

    ```console
    $ docker exec -it mypostgres-master \
                  su -c "psql -c \"CREATE USER replicator REPLICATION LOGIN PASSWORD 'replpass';\" pacsdb pacs"
    ```
5. Initialize database files of the 'slave' DB by running `pg_basebackup` against the 'master' DB:

    ```console
    $ docker run -v /var/local/mypacs/slave_db:/var/lib/postgresql/data \
                 --add-host=db:<mypostgres-master-ip> \
                 --rm -it dcm4che/postgres-dcm4chee \
                 su -c "pg_basebackup -h db -D /var/lib/postgresql/data -Ureplicator -P -v -x"
    ```
6. Configure parameters needed for log-streaming replication standby in Recovery Configuration file `recovery.conf`:

    ```console
    $ cat << EOF > /var/local/mypacs/slave_db/recovery.conf
    primary_conninfo = 'host=db port=5432 user=replicator password=replpass'
    trigger_file = '/var/lib/postgresql/data/failover'
    standby_mode = 'on'
    EOF
    ```
7. Adjust the permissions of the data directory:

    ```console
    $ chmod 700 /var/local/mypacs/slave_db
    ```
8. Start another container with Postgres acting as 'slave' DB connected with the 'master' DB:

    ```console
    $ docker run --name mypostgres-slave \
                 -p 25432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacsword \
                 -v /var/local/mypacs/slave_db:/var/lib/postgresql/data \
                 --add-host=db:<mypostgres-master-ip> \
                 -d dcm4che/postgres-dcm4chee
    ```
