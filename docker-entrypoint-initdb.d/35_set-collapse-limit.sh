#!/bin/sh

sed -i -e "s/^#join_collapse_limit = 8/join_collapse_limit = 16/" /var/lib/postgresql/data/postgresql.conf
sed -i -e "s/^#from_collapse_limit = 8/from_collapse_limit = 16/" /var/lib/postgresql/data/postgresql.conf
