FROM nginx:1.7

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl supervisor

ENV CT_URL https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz
RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

RUN rm -v /etc/nginx/conf.d/*
COPY nginx.ctmpl /etc/consul-templates/nginx.ctmpl
COPY supervisord.conf /etc/supervisor/conf.d/nginx.conf

ENTRYPOINT ["/usr/bin/supervisord"]