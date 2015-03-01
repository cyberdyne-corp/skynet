FROM haproxy:1.5

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl && \
    rm -rf /var/lib/apt/lists/*

ENV CT_URL https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz
RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

COPY startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh
COPY reload.sh /tmp/reload.sh
RUN chmod +x /tmp/reload.sh
COPY haproxy.ctmpl /etc/consul-templates/haproxy.ctmpl

CMD ["/tmp/startup.sh"]