#!/bin/bash

echo "Stalling for MySQL"
while true; do
    nc -q 1 promdashdb 3306 >/dev/null && break
done

rake db:migrate

bin/env bin/bundle exec bin/thin -p 3000 start
