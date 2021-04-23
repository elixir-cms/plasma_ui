#!/usr/bin/env sh

source $PWD/.envrc

if [ $1 == "start" ]; then
    if [ ! -d $PGHOST ]; then
        mkdir -p $PGHOST
    fi
    if [ ! -d $PGDATA ]; then
        echo 'Initializing postgres database'
        initdb $PGDATA --auth=trust >/dev/null
        echo 'Starting postgres'
        pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
        psql -c "create role postgres with createdb login password 'postgres';"
    else
        echo 'Starting postgres'
        pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
    fi
fi

if [ $1 == "stop" ]; then
    echo 'Stopping postgres'
    pg_ctl stop -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
fi

exit 0
