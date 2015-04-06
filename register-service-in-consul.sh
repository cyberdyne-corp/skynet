#!/usr/bin/env bash

usage() {
	echo "Usage: `basename $0` <SERVICE_ID> <SERVICE_PORT>"
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

SERVICE_ID=$1
SERVICE_PORT=$2

curl -X PUT -d "{\"ID\": ${SERVICE_ID}, \"Name\":\"myService\", \"Port\": ${SERVICE_PORT}, \"Tags\": [\"myTag\"]}" "http://localhost:8500/v1/agent/service/register"

exit 0
