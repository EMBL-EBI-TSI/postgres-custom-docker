FROM postgres:9.5
MAINTAINER Amélie Cornélis "ameliec@ebi.ac.uk"

# Create the conf.d folder and put the customisation(s) there
RUN mkdir /var/lib/postgresql/conf.d
ADD *.conf /var/lib/postgresql/conf.d/
# Tell postgres to look in the conf.d folder
ADD use_conf_folder.sh /docker-entrypoint-initdb.d/

HEALTHCHECK --interval=5s --retries=20 CMD grep database\ system\ was\ shut\ down\ at /var/lib/postgresql/data/pg_log/postgresql*.log && psql -U $POSTGRES_USER -c 'select count(*) from pg_stat_activity;' || exit 1
