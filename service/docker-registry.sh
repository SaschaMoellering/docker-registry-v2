#!/bin/bash

#
# chkconfig: 2345 95 05
# description: docker-registry
#

BASE=$(basename $0)
DOCKER_REGISTRY_PIDFILE=/var/run/$BASE.pid

fail_unless_root() {
  if [ "$(id -u)" != '0' ]; then
    echo "docker-registry must be run as root"
    exit 1
  fi
}

case "$1" in
  start)
    fail_unless_root
    
    echo $! > $DOCKER_REGISTRY_PIDFILE
    ;;

  stop)
    fail_unless_root
    log_begin_msg "Stopping docker-regitry: $BASE"
    start-stop-daemon --stop --pidfile "$DOCKER_REGISTRY_PIDFILE"
    log_end_msg $?
    ;;

    *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

exit 0