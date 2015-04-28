FROM prom/promdash:latest

RUN apt-get update && apt-get install netcat-openbsd 

COPY startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh

CMD ["/tmp/startup.sh"]