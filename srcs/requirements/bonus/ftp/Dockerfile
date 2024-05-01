FROM debian:bullseye

RUN apt update && apt-get install -y vsftpd

RUN useradd kzegani && \
    echo kzegani:123 | chpasswd && \
    mkdir /home/kzegani && \
    chmod a-w /home/kzegani && \
    chown kzegani:kzegani /home/kzegani

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/entrypoint.sh /

CMD sh /entrypoint.sh