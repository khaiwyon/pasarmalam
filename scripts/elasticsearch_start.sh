PID_FILE=/var/run/$NAME.pid
DAEMON=/usr/share/elasticsearch/bin/elasticsearch
DAEMON_OPTS="-d -p $PID_FILE -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR"

$DAEMON $DAEMON_OPTS

