# docker-skynet

A stack used to automatically register Docker container hosting webapps as services in Consul, distribute them using HAProxy and monitor it with Prometheus.

# About

Powered by the following tools:

* Docker: a portable, lightweight runtime and packaging tool.
> See: https://www.docker.com/

* Docker-compose: a tool used to manage an application in distributed containers.
> See: https://docs.docker.com/compose/

* HAProxy: a TCP/HTTP load balancer.
> See: http://www.haproxy.org/

* Consul: a tool for discovering and configuring services in your infrastructure.
> See: https://www.consul.io/

* Consul-template: a daemon used to populate values from Consul on your filesystem.
> See: https://github.com/hashicorp/consul-template

* Registrator: a tool that automatically register/deregister Docker containers into Consul.
> See: https://github.com/gliderlabs/registrator

* Prometheus: An open-source service monitoring system and time series database.
> See: http://prometheus.io/

![poc_hld][hld]

# How to

## Pre-requisites

Ensure you have Docker and Docker Compose installed:

* Docker installation: http://docs.docker.com/installation/
* Docker Compose installation: https://docs.docker.com/compose/#installation-and-set-up

Then, update the *docker-compose.yml* file and replace *ROUTABLE_IP* with a routable IP address (use your main interface IP address).

## Let's play

### Start it

Start the stack:

````
$ docker-compose pull & docker-compose build
$ docker-compose up -d
````

### Start a webapp

You'll need to have a containerized webapp available.

#### Default

You can use a default webapp for the basics:

````
$ docker run -d -e "SERVICE_NAME=myService" -e "SERVICE_TAGS=myTag" -p 80 -d tutum/hello-world
````

#### Advanced

If you want to use the embedded webapp with consul health check, you'll need to build it first:

```
$ docker build -t backend backend/
```

Then run it:

```
$ docker run -d -P \
    -e "SERVICE_NAME=myService" \
    -e "SERVICE_TAGS=myTag" \
    -e "SERVICE_8081_IGNORE=1" \
    -e "SERVICE_8080_CHECK_CMD=/tmp/health-check.sh" \
    -e "SERVICE_8080_CHECK_INTERVAL=15s" \
    backend \
    java -jar /tmp/backend.jar
```

Point your browser at http://localhost to see the result.

### Consul

You can place different configuration files in consul/config, they will be loaded by Consul.

You can place your watch handlers inside consul/handlers, it will be mapped on the container in */handlers*.

You can access the Consul UI via http://localhost:8500

### Prometheus

Access the Prometheus UI via http://localhost:9090

[hld]: https://www.lucidchart.com/publicSegments/view/552915db-7dc4-490d-861c-2e260a00ce7d/image.png "HLD"
