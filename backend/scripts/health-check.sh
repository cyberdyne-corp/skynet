#!/usr/bin/env bash

# Stalling for the management port to be ready.
while true; do
    nc -q 1 localhost 8081 > /dev/null && break
done

RET=$(/usr/bin/http -b http://localhost:8081/health | /usr/bin/jq -e 'contains({status: "UP"})')
CODE=$?

# Ensure the return code is 1 on error. 
# We want the service check state to be 'warning' in Consul, as every service check starts with a 'critical' state.
# See: https://github.com/hashicorp/consul/issues/706
if [[ $CODE -ne 0 ]]; then
	CODE=1
fi

echo "$(date) - Check status: ${CODE}"

exit $CODE