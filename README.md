# pg-dumper

pg-dumper is a simple cli script to easily dump, compress, encrypt and optionally upload your postgres database/cluster.

---

### Requirements
In order to run the script you need to have gnupg, gzip, the minio client (mc) and pg_dump/pg_dumpall installed (version should match the postgres server).

### Make script executable
```shell
chmod +x pg-dumper.sh
```

### Backup with encryption enabled
```shell
./pg-dumper.sh --host localhost --db app --password postgres --user postgres --port 5432 --backup-password supersecret --location ./
```

### Backup with encryption disabled
```shell
./pg-dumper.sh --host localhost --db app --password postgres --user postgres --port 5432 location ./ --encryption false
```

---

### Extract backup with encryption enabled
```shell
gpg -d backup_file.gpg | gzip -dc > backup_file.sql
```

### Extract backup with encryption disabled
```shell
gzip -dc backup_file.gz > backup_file.sql
```

### Parameters

| Parameter      | Description | Default |
| ----------- | ----------- | ----------- | 
| host      | Postgres host       | (required)
| user   | Postgres user        | (required)
| password   | Postgres password        | (required)
| db   | Postgres db        | (required if cluster-wide is false)
| port   | Postgres port        | 5432
| location   | Location for the backup        | $HOME
| backup-password   | Password for encryption        | (required if encryption is true)
| encryption   | Enable/disable encryption        | true
| cluster-wide   | If true it will use pg_dumpall to dump the whole cluster        | false
| upload   | If true it will upload the backup to a s3 compatible storage        | false
| endpoint   | s3 compatible endpoint       | (required if upload is true)
| bucket   | s3 bucket for uploading (needs to end with a slash)       | (required if upload is true)
| access-key   | s3 compatible storage access-key       | (required if upload is true)
| access-secret   | s3 compatible storage secret-key       | (required if upload is true)
| api-version   | api-signature (minio client)       | S3v4
| minio-client   | custom location of the minio client (e.g ./mc)      | mc

### Build docker image
```shell
# Example to build for postgres 11.14
docker build --no-cache --build-arg PG_VERSION=11.14 -t pg-dumper:postgres-11.14 .
```

### Prebuild docker images
https://hub.docker.com/r/gtuk/pg-dumper

```shell
docker run gtuk/pg-dumper:postgres-11.14 --host <HOST> --password <PASSWORD> --user <USER> --port <PORT> --backup-password <SUPER_SECRET_PASSWORD> --location ./ --cluster-wide true --upload true --endpoint <ENDPOINT> --access-key <ACCESS_KEY> --secret-key <SECRET_KEY> --bucket <BUCKET> --minio-client ./mc
```
