FROM progrium/consul:latest

COPY handlers/ /handlers
RUN chmod +x /handlers/keyprefix-handler.sh

RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o /bin/jq \
  && chmod +x /bin/jq
