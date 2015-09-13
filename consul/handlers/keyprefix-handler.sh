#!/usr/bin/env bash

DATA=$(cat)

SERVICE_NAMES=$(echo "${DATA}" | jq '.[] | .Key')
for SERVICE in ${SERVICE_NAMES}
do
	STRIPPED_SERVICE="${SERVICE##*/}"
	STRIPPED_SERVICE="${STRIPPED_SERVICE%\"}"
	ENCODED_VALUE=$(echo "${DATA}" | jq ".[] | select(.Key == ${SERVICE}) | .Value")
	VALUE=$(echo "${ENCODED_VALUE}" | base64 -d)
	curl -H "Content-Type: application/json" -X POST -d "{\"number\": ${VALUE}}" "http://genisys.service.consul:7001/service/${STRIPPED_SERVICE}/scale"
done

exit 0
