#!/usr/bin/env bash

usage() {
	echo "Usage: `basename $0` <SERVICE_ID>"
    exit 1
}

if [[ $# -ne 1 ]]; then
    usage
fi

SERVICE_ID=$1

curl -X PUT "http://localhost:8500/v1/agent/service/deregister/${SERVICE_ID}"

exit 0
