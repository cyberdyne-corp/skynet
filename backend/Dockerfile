FROM java:7

RUN apt-get update && apt-get install -y httpie jq

COPY scripts/health-check.sh /tmp/health-check.sh
RUN chmod +x /tmp/health-check.sh

ADD https://github.com/rems/docker-helloworld/releases/download/0.0.3/demo-0.0.3.jar /tmp/backend.jar

EXPOSE 8080 8081