FROM dockerfile/java:oracle-java7

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y httpie jq/trusty-backports

COPY scripts/health-check.sh /tmp/health-check.sh
RUN chmod +x /tmp/health-check.sh

ADD https://github.com/rems/docker-helloworld/releases/download/0.0.1/demo-0.0.1-SNAPSHOT.jar /tmp/backend.jar

EXPOSE 8080 8081