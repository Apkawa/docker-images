# Docker + Postgres + Wal-G

Docker with scripts to ease process of testing backup and restoration of postgres + wal-g + s3
TODO add process to check data integrity, custom tailored for user

Based on docker image `postgres:11` and `wal-g==0.2.10`

## Build

```
docker build -t apkawa/postgres-10-wal-g .
```

## Requirement

Create and fill the file `docker-env-file.example` according to your environment.
You can add wal-g and postgres environments variables.
```
AWS_ACCESS_KEY_ID=*required*
AWS_SECRET_ACCESS_KEY=*required*
AWS_REGION=*required (avoid adding permissions on aws)*
WALG_S3_PREFIX=*required (s3://bucket-name/custom-path)*

PGHOST=/var/run/postgresql
PGUSER=postgres
PGDATABASE=postgres
```

AWS User creds used must at least have these permissions
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::bucket-name"
            ]
        },
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::bucket-name/*"
        }
    ]
}
```

## Dump

* Start the DB
* Set up wal_archiving and restart the DB
* execute a full backup
* Use pgbench to fill it
* execute a full backup
* Quit


```
docker run --env-file [your env file] apkawa/postgres-10-wal-g dump.sh [a
```

## Load

* Fetch the backup
* Set up recovery.conf
* Start the DB

```
docker run --env-file [your env file] apkawa/postgres-10-wal-g load.sh [{backup_name}|LATEST]
```

## Migrate from existing db

Add to postgresql.conf

```
wal_level=replica
# or maybe
# wal_level=archive
archive_mode=on
archive_command='sh /usr/local/bin/archive.sh %p'
archive_timeout=60
```


# Links

* [WAL-G](https://github.com/wal-g/wal-g/tree/v0.2.9)
* [PostgreSQL](https://www.postgresql.org/docs/10/index.html)