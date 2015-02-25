# docker-CRN

A stack used to automatically register Docker container hosting webapps as services in Consul and distribute them using Nginx.

# About

Powered by the following tools:

* Fig: a tool used to manage an application in distributed containers.
> See: http://www.fig.sh/

* Nginx: an HTTP and reverse proxy server.
> See: http://nginx.org/

* Consul: a tool for discovering and configuring services in your infrastructure.
> See: https://www.consul.io/

* Consul-template: a daemon used to populate values from Consul on your filesystem.
> See: https://github.com/hashicorp/consul-template

* Registrator: a tool that automatically register/deregister Docker containers into Consul.
> See: https://github.com/gliderlabs/registrator

# How to

## Pre-requisites

Ensure you have Docker installed.

Install fig:

````
$ sudo pip install -U fig
````

Update the *fig.yml* file and replace *ROUTABLE_IP* with a routable IP address (use your main interface IP address).

## Let's play

### Start it

Start the Nginx + Consul + Registrator stack:

````
$ fig pull & fig build
$ fig up -d
````

### Start a webapp

You'll need to have a containerized webapp available.

````
$ docker run -d -e "SERVICE_NAME=my_service" -e "SERVICE_TAGS=my_tag" -p 80 -d tutum/hello-world
````

Point your browser at http://localhost to see the result.

### Consul

You can place different configuration files in consul/config, they will be loaded by Consul.

You can place your watch handlers inside consul/handlers, it will be map on the container in */handlers*.

You can access the Consul UI via http://localhost:8500

