FROM mariadb:latest as builder

# That file does the DB initialization but also runs mysql daemon, by removing the last line it will only init
RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]

# Intialization. Settings are based on ddev defaults.
ENV MARIADB_ROOT_PASSWORD=root
ENV MARIADB_DATABASE=db
ENV MARIADB_USER=db
ENV MARIADB_PASSWORD=db

# Copy an sql file into the init directory, and it will be automatically imported.
COPY *.sql /docker-entrypoint-initdb.d/

# Need to change the datadir to something other than /var/lib/mysql because the parent docker file defines it as a volume.
# https://docs.docker.com/engine/reference/builder/#volume :
#       Changing the volume from within the Dockerfile: If any build steps change the data within the volume after
#       it has been declared, those changes will be discarded.
RUN ["/usr/local/bin/docker-entrypoint.sh", "mariadbd", "--datadir", "/initialized-db", "--aria-log-dir-path", "/initialized-db"]

# Now build the final image.
FROM mariadb:latest

COPY --from=builder /initialized-db /var/lib/mysql
