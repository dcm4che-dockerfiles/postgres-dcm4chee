This docker image provides PostgreSQL initalized for the DICOM Archive
[dcm4chee-arc-light](https://github.com/dcm4che/dcm4chee-arc-light/wiki).
It extends the [official postgres image](https://hub.docker.com/_/postgres/).

# How to use this image

## start a postgres instance

```
$ docker run --name postgres \
           -p 5432:5432 \
           -v /etc/localtime:/etc/localtime \
           -e POSTGRES_DB=pacsdb \
           -e POSTGRES_USER=pacs\
           -e POSTGRES_PASSWORD=pacs \
           -v /var/local/dcm4chee-arc/db:/var/lib/postgresql/data \
           -d dcm4che/postgres-dcm4chee:14.4-27
````

## connect to it from the DICOM Archive application

```
$ docker run --link postgres:db ... -d dcm4che/dcm4chee-arc-psql
```

## Environment Variables

This image does not define additional environment variables to those inherited from the PostgreSQL image. But in
opposite to the base image, they are required - except `PGDATA` - to be specified, because the DICOM Archive
application relies on their provision.

### `POSTGRES_USER`

This environment variable is used in conjunction with `POSTGRES_PASSWORD` to set a user and its password. This variable
will create the specified user with superuser power.

### `POSTGRES_USER_FILE`

Superuser via file input (alternative to `POSTGRES_USER`). 

### `POSTGRES_PASSWORD`

Superuser password for PostgreSQL. In the above example, it is being set to `pacs`.

### `POSTGRES_PASSWORD_FILE`

Superuser password for PostgreSQL via file input (alternative to `POSTGRES_PASSWORD`). 

### `POSTGRES_DB`

This environment variable defines the name for the default database that is created when the image is first started.

### `PGDATA`

This optional environment variable can be used to define another location - like a subdirectory - for the database files.
The default is `/var/lib/postgresql/data`, but if the data volume you're using is a fs mountpoint (like with GCE
persistent disks), Postgres `initdb` recommends a subdirectory (for example `/var/lib/postgresql/data/pgdata` ) be
created to contain the data.

## Setup Master/Slave Replication

1. Start a container with Postgres acting as 'master' DB:

    ```
    $ docker run --name db1 \
                 -p 5432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacs \
                 -v /path/to/db1:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee:14.4-27
    ```
2. Allow all hosts to replicate with this 'master' DB:

    ```
    $ echo 'host replication replicator 0.0.0.0/0 trust' >> /path/to/db1/pg_hba.conf
    $ cat << EOF >> /path/to/db1/postgresql.conf
    wal_level = hot_standby
    max_wal_senders = 3
    wal_keep_size = 128
    EOF
    ```
3. Restart the container:

    ```
    $ docker restart db1
    ```
4. Create a user for replication:

    ```
    $ docker exec -it db1 \
                  su -c "psql -c \"CREATE USER replicator REPLICATION LOGIN PASSWORD 'replpass';\" pacsdb pacs"
    ```
5. Initialize database files of the 'slave' DB by running `pg_basebackup` against the 'master' DB:

    ```
    $ docker run -v /path/to/db2:/var/lib/postgresql/data \
                 --rm -it dcm4che/postgres-dcm4chee:14.4-27 \
                 su -c "pg_basebackup -h <ip-of-db1-host> -D /var/lib/postgresql/data -Ureplicator -P -v -Xfetch -R"
    ```
6. Start another container with Postgres acting as 'slave' DB connected with the 'master' DB:

    ```
    $ docker run --name db2 \
                 -p 6432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacs \
                 -v /path/to/db2:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee:14.4-27
    ```

## Initiate failover from 'master' DB to 'slave' DB

1. Execute `pg_ctl promote` as user `postgres` in the container acting as 'slave' DB:

    ```console
    $ docker exec db2 runuser -u postgres pg_ctl promote
    waiting for server to promote.... done
    server promoted
    ```

  to exit standby mode and switch the server to normal operation to act as new 'master' DB'.
  
## Recover previous 'master' DB after failover to 'slave' DB

1. Ensure the previous 'master' DB is stopped and remove the container:

    ```
    $ docker stop db1
    $ docker rm -v db1
    ```
2. Delete the database files of the  'master' DB:

    ```
    $ rm -r /path/to/db1
    ```
3. Initialize database files of the new 'slave' DB by running `pg_basebackup` against the new 'master' DB:

    ```
    $ docker run -v /path/to/db1:/var/lib/postgresql/data \
                 --rm -it dcm4che/postgres-dcm4chee:14.4-27 \
                 su -c "pg_basebackup -h <ip-of-db2-host> -D /var/lib/postgresql/data -Ureplicator -P -v -Xfetch -R"
    ```
4. Start another container with Postgres acting as new 'slave' DB connected with the new 'master' DB:

    ```
    $ docker run --name db1 \
                 -p 5432:5432 \
                 -e POSTGRES_DB=pacsdb \
                 -e POSTGRES_USER=pacs \
                 -e POSTGRES_PASSWORD=pacs \
                 -v /path/to/db1:/var/lib/postgresql/data \
                 -d dcm4che/postgres-dcm4chee:14.4-27
   ```
