This docker image provides PostgreSQL initalized for the DICOM Archive
[dcm4chee-arc-light](https://github.com/dcm4che/dcm4chee-arc-light/wiki).
It extends the [official postgres image](https://hub.docker.com/_/postgres/).

# How to use this image

## start a postgres instance

```console
$ docker run --name mypostgres \
             -p 5432:5432 \
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
    $ docker run --name db1 \
                 -p 5432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacsword \
                 -v /path/to/db1:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee
    ```
2. Allow all hosts to replicate with this 'master' DB:

    ```console
    $ echo 'host replication replicator 0.0.0.0/0 trust' >> /path/to/db1/pg_hba.conf
    $ cat << EOF >> /path/to/db1/postgresql.conf
    wal_level = hot_standby
    checkpoint_segments = 8
    max_wal_senders = 3
    wal_keep_segments = 8
    hot_standby = on
    EOF
    ```
3. Restart the container:

    ```console
    $ docker restart db1
    ```
4. Create a user for replication:

    ```console
    $ docker exec -it db1 \
                  su -c "psql -c \"CREATE USER replicator REPLICATION LOGIN PASSWORD 'replpass';\" pacsdb pacs"
    ```
5. Initialize database files of the 'slave' DB by running `pg_basebackup` against the 'master' DB:

    ```console
    $ docker run -v /path/to/db2:/var/lib/postgresql/data \
                 --rm -it dcm4che/postgres-dcm4chee \
                 su -c "pg_basebackup -h <ip-of-db1-host> -D /var/lib/postgresql/data -Ureplicator -P -v -x"
    ```
6. Configure parameters needed for log-streaming replication standby in Recovery Configuration file `recovery.conf`:

    ```console
    $ cat << EOF > /path/to/db2/recovery.conf
    primary_conninfo = 'host=<ip-of-db1-host> port=5432 user=replicator password=replpass'
    trigger_file = '/var/lib/postgresql/data/failover'
    standby_mode = 'on'
    EOF
    ```
7. Adjust the permissions of the data directory:

    ```console
    $ chmod 700 /path/to/db2
    ```
8. Start another container with Postgres acting as 'slave' DB connected with the 'master' DB:

    ```console
    $ docker run --name db2 \
                 -p 5432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacsword \
                 -v /path/to/db2:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee
    ```

## Initiate failover from 'master' DB to 'slave' DB

1. Create trigger file `failover` in the data directory of the slave DB:

    ```console
    $ touch /var/local/mypacs/slave_db/failover
    ```

  Postgres will remove the trigger file and rename Recovery Configuration file `recovery.conf`
  to `recovery.done`, indicating that the 'slave' DB is no longer in standby mode, but is acting
  as new 'master' DB'.
  
## Recover previous 'master' DB after failover to 'slave' DB

1. Ensure the previous 'master' DB is stopped and remove the container:

    ```console
    $ docker stop db1
    $ docker rm -v db1
    ```
2. Delete the database files of the  'master' DB:

    ```console
    $ rm -r /path/to/db1
    ```
3. Initialize database files of the new 'slave' DB by running `pg_basebackup` against the new 'master' DB:

    ```console
    $ docker run -v /path/to/db1:/var/lib/postgresql/data \
                 --rm -it dcm4che/postgres-dcm4chee \
                 su -c "pg_basebackup -h <ip-of-db2-host> -D /var/lib/postgresql/data -Ureplicator -P -v -x"
    ````
4. Configure parameters needed for log-streaming replication standby in Recovery Configuration file `recovery.conf`:

    ```console
    $ cat << EOF > /path/to/db1/recovery.conf
    primary_conninfo = 'host=<ip-of-db2-host> port=5432 user=replicator password=replpass'
    trigger_file = '/var/lib/postgresql/data/failover'
    standby_mode = 'on'
    EOF
    ```
5. Adjust the permissions of the data directory:

    ```console
    $ chmod 700 /path/to/db1
    ```
6. Start another container with Postgres acting as new 'slave' DB connected with the new 'master' DB:

    ```console
    $ docker run --name db1 \
                 -p 5432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacsword \
                 -v /path/to/db1:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee
