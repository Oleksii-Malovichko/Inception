FROM debian:bookworm

# RUN apt update && apt install mariadb-server -y && rm -rf /var/lib/apt/lists/* && apt clean
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/init_db.sh /init_db.sh

RUN chmod +x /init_db.sh

# set port 3306
EXPOSE 3306

# run process in pid 1
ENTRYPOINT ["/init_db.sh"]