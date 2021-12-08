ARG PG_VERSION=latest
FROM postgres:${PG_VERSION}

RUN apt-get update && \
    apt-get install -y gnupg gzip wget

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc

ADD pg-dumper.sh ./pg-dumper.sh
RUN chmod +x ./pg-dumper.sh

ENTRYPOINT ["./pg-dumper.sh"]
