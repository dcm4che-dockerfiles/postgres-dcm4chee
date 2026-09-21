#!/bin/sh

CONF_FILE=$(find /var/lib/postgresql -name postgresql.conf | head -n 1)
if [ -n "$CONF_FILE" ]; then
    sed -i -e "s/^#join_collapse_limit = 8/join_collapse_limit = 16/" "$CONF_FILE"
    sed -i -e "s/^#from_collapse_limit = 8/from_collapse_limit = 16/" "$CONF_FILE"
else
    echo "postgresql.conf not found, skipping collapse limit configuration"
fi
