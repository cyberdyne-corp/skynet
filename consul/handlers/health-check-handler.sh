#!/usr/bin/env bash

LOG_FILE=/tmp/health-check.log
PROMETHEUS_JOB=helloworld
PROMETHEUS_METRIC=service_state

log() {
	echo "$1" >> ${LOG_FILE}
}

kill_container() {
	$(docker kill $1)
}

spawn_container() {
	$(docker run -d -P \
		-e "SERVICE_NAME=my_service" \
		-e "SERVICE_TAGS=my_tag" \
		-e "SERVICE_8081_IGNORE=1" \
		-e "SERVICE_8080_CHECK_CMD=/tmp/health-check.sh" \
		-e "SERVICE_8080_CHECK_INTERVAL=15s" \
		backend \
		java -jar /tmp/backend.jar)
}

# Push a metric to the Prometheus push gateway.
# $1. Instance name
# $2. Container name
# $3. Metric value
push_to_prometheus() {
	MESSAGE="# TYPE ${PROMETHEUS_METRIC} gauge\n# HELP ${PROMETHEUS_METRIC} Service state.\n${PROMETHEUS_METRIC}{docker_host=\"$1\"} $3"
	echo -e $MESSAGE | curl --data-binary @- "http://pushgateway:9091/metrics/jobs/${PROMETHEUS_JOB}/instances/$2"
}

# Retrieve JSON watch data from stdin.
VALUE=$(cat)

TUPLE_SERVICE_STATUS_NODE=$(echo ${VALUE} | jq "group_by(.Status) | .[] | .[] | { ServiceID, Status, Node } ")
SERVICE_LIST=$(echo ${TUPLE_SERVICE_STATUS_NODE} | jq ".ServiceID")

for SERVICE in ${SERVICE_LIST}
do
  	SERVICE_INFO=(${SERVICE//:/ })
  	SERVICE_STATE=$(echo ${TUPLE_SERVICE_STATUS_NODE} | jq -r "select( .ServiceID == ${SERVICE} ) | .Status" )
  	NODE=$(echo ${TUPLE_SERVICE_STATUS_NODE} | jq -r "select( .ServiceID == ${SERVICE} ) | .Node" )
  	CONTAINER_NAME=${SERVICE_INFO[1]}

  	log "$(date) - Service ${SERVICE} (node: ${NODE} | container: ${CONTAINER_NAME}) is in state: ${SERVICE_STATE}"
	
	if [ "${SERVICE_STATE}" == "warning" ]; then
		kill_container "${CONTAINER_NAME}"
		spawn_container
		log "$(date) - Container killed: ${CONTAINER_NAME}. A new one has spawn."
		push_to_prometheus "${NODE}" "${CONTAINER_NAME}" "0"
	elif [ "${SERVICE_STATE}" == "passing" ]; then
		push_to_prometheus "${NODE}" "${CONTAINER_NAME}" "1"
	fi
done

exit 0