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

* Nginx: an HTTP and reverse proxy server.
> See: http://nginx.org/

* Consul: a tool for discovering and configuring services in your infrastructure.
> See: https://www.consul.io/

* Consul-template: a daemon used to populate values from Consul on your filesystem.
> See: https://github.com/hashicorp/consul-template

* Registrator: a tool that automatically register/deregister Docker containers into Consul.
> See: https://github.com/gliderlabs/registrator

![poc_hld][hld]

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

Start a "version A" application:

````
$ docker run -d \
-e "SERVICE_NAME=myService" \
-p 80 \
-v ${PWD}/backend/version-a:/var/www \
eboraas/apache
````

You should be able to see the result in your browser at: http://localhost

Next, start a "version B" application:

````
$ docker run -d \
-e "SERVICE_NAME=myService" \
-p 80 \
-v ${PWD}/backend/version-b:/var/www \
eboraas/apache
````

Point your browser at http://localhost to see the result, you should now be load balanced between the 2 versions of the application.

Now all you need to do is to stop your "version A" container, no more, and enjoy a blue-green deployment !

## Extras

### Consul

You can place different configuration files in consul/config, they will be loaded by Consul.

You can access the Consul UI via http://localhost:8500

[hld]: https://www.lucidchart.com/publicSegments/view/5522790b-efb4-46eb-a384-590a0a00ce7d/image.png "HLD"
