# docker-CRPH

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

````
$ docker run -d -e "SERVICE_NAME=my_service" -e "SERVICE_TAGS=my_tag" -p 80 -d tutum/hello-world
````

Point your browser at http://localhost to see the result.

### Consul

You can place different configuration files in consul/config, they will be loaded by Consul.

You can place your watch handlers inside consul/handlers, it will be mapped on the container in */handlers*.

You can access the Consul UI via http://localhost:8500

### Prometheus

Access the Prometheus UI via http://localhost:9090

Access the Prometheus Gateway UI via http://localhost:9091
