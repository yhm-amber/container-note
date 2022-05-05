FROM mysql:5.7
COPY init.sh /docker-entrypoint-initdb.d/init.sh
COPY creator.sh /creator.sh
COPY Dockerfile /Dockerfile

COPY env.sh /etc/profile.d/env.sh
COPY env.sh /root/.bashrc
COPY env.sh /home/mysql/.bashrc
ENV MARIADB_ROOT_PASSWORD="root-$PSWD_SUFFIX" MYSQL_ROOT_PASSWORD="$MARIADB_ROOT_PASSWORD" 
