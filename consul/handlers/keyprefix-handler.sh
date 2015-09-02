#!/usr/bin/env bash

log() {
	echo "$1" >> /tmp/watch.log
}

DATA=$(cat)

SERVICE_NAMES=$(echo "${DATA}" | jq '.[] | .Key')
log "Service names: ${SERVICE_NAMES}"
for SERVICE in ${SERVICE_NAMES}
do
	log "Service: ${SERVICE}"
	STRIPPED_SERVICE="${SERVICE##*/}"
	STRIPPED_SERVICE="${STRIPPED_SERVICE%\"}"
	log "Stripped service: ${STRIPPED_SERVICE}"
	ENCODED_VALUE=$(echo "${DATA}" | jq ".[] | select(.Key == ${SERVICE}) | .Value")
	log "Encoded value: ${ENCODED_VALUE}"
	VALUE=$(echo "${ENCODED_VALUE}" | base64 -d)
	log "Value: ${VALUE}"
	curl -H "Content-Type: application/json" -X POST -d "{\"number\": ${VALUE}}" "http://genisys:7001/service/${STRIPPED_SERVICE}/scale"
done

exit 0

# List services: cat sample.json| jq '.[] | .Key'
# Get value for service: cat sample.json| jq '.[] | select(.Key == "skynet/skynet_b2/resources") | .Value'
# Use echo $VALUE |base64 --decode to decode values

# Sample: [{"Key":"skynet/skynet_backend/resources","CreateIndex":11,"ModifyIndex":11,"LockIndex":0,"Flags":0,"Value":"Mw==","Session":""}]
# [
#    {
#       "Key":"skynet/skynet_b2/resources",
#       "CreateIndex":12,
#       "ModifyIndex":12,
#       "LockIndex":0,
#       "Flags":0,
#       "Value":"Mw==",
#       "Session":""
#    },
#    {
#       "Key":"skynet/skynet_backend/resources",
#       "CreateIndex":11,
#       "ModifyIndex":11,
#       "LockIndex":0,
#       "Flags":0,
#       "Value":"Mw==",
#       "Session":""
#    }
# ]
