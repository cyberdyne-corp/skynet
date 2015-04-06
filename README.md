# docker-skynet

A management stack for web applications.

# POC: Blue-Green deployment

This is a Proof-Of-Concept for a web application deployment using the Blue-Green approach.

> What is Blue-Green deployment: http://martinfowler.com/bliki/BlueGreenDeployment.html

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

# How to

## Pre-requisites

Ensure you have Docker and Docker Compose installed:

* Docker installation: http://docs.docker.com/installation/
* Docker Compose installation: https://docs.docker.com/compose/#installation-and-set-up 

Then, update the *docker-compose.yml* file and replace *ROUTABLE_IP* with a routable IP address (use your main interface IP address).

## Let's play

### Build and start the stack

Build it:

````
$ docker-compose pull && docker-compose build
````

Start it:

````
$ docker-compose up -d
````

### Do some blue-green magic

Start a "version A" container:

````
$ docker run -d \
-p 80 \
-v ${PWD}/backend/version-a:/var/www \
eboraas/apache
````

Retrieve the container name using ```docker ps``` and register it in Consul:

````
$ ./register-service-in-consul.sh `docker inspect -f '"{{ .Config.Hostname }}:{{ .Name }}{{ range $key, $value := .NetworkSettings.Ports }}:{{ $key }}" {{ (index $value 0).HostPort }}{{ end }}' CONTAINER_A_NAME`
````

You should be able to see the result in your browser at: http://localhost

Next, start a "version B" container:

````
$ docker run -d \
-p 80 \
-v ${PWD}/backend/version-b:/var/www \
eboraas/apache
````

And register it in Consul:

````
$ ./register-service-in-consul.sh `docker inspect -f '"{{ .Config.Hostname }}:{{ .Name }}{{ range $key, $value := .NetworkSettings.Ports }}:{{ $key }}" {{ (index $value 0).HostPort }}{{ end }}' CONTAINER_B_NAME`
````

Point your browser at http://localhost to see the result, you should now be load balanced between the 2 versions of the application.

Now all you need to do is to deregister your "version A" container from Consul:

````
$ ./deregister-service-in-consul.sh `docker inspect -f '{{ .Config.Hostname }}:{{ .Name }}{{ range $key, $value := .NetworkSettings.Ports }}:{{ $key }}{{ end }}' CONTAINER_A_NAME`
````

And that's it, enjoy some blue green deployment ! 

Optionally, you can kill the "version A" container ;)

### Register/deregister scripts

#### register-service-in-consul.sh

The script requires 2 parameters:

* SERVICE_ID: the ID of the service to register
* SERVICE_PORT: the port used to access the service

It calls the Consul HTTP API to register a service using the */v1/agent/service/register* endpoint.

#### deregister-service-in-consul.sh

The script requires 1 parameter:

* SERVICE_ID: the ID of the service to deregister

It calls the Consul HTTP API to deregister a service using the */v1/agent/service/deregister/SERVICE_ID* endpoint.

## Extras

### Consul

You can place different configuration files in consul/config, they will be loaded by Consul.

You can access the Consul UI via http://localhost:8500

### HAProxy

You can access the HAProxy stats webpage at: http://localhost:1936
