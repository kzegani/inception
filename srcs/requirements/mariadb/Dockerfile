FROM debian:bullseye

RUN apt update && apt install mariadb-server -y

COPY conf/db.sql /
COPY conf/db_root.sql /

COPY tools/entrypoint.sh .

CMD bash entrypoint.sh
