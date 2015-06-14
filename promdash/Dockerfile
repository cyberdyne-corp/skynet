FROM prom/promdash:latest

ENV DATABASE_URL sqlite3:/tmp/promdash.sqlite3

RUN bin/env bin/bundle exec rake db:migrate
