======
Skynet
======

An intelligent solution for infrastructure management.

Introduction
============

The Skynet stack is a set of tools, it aims to help you managing your IT infrastructure.

It offers:

* elastic scaling of any kind of service (database, web server, application server...)
* ability to deploy software without service interruption with blue/green deployment
* complete monitoring including self-monitoring with alerting
* ...

Elastic scaling relays on metrics to automatically adjust required resources (scale up/down). Metrics can be of any type:

* HTTP requests per second
* Number of established connections to a database
* Inbound TCP traffic
* CPU usage over time
* ...

It should work with any virtualization technology:

 * VMWare
 * Docker
 * ...

And it aims to be provider agnostic, with the following support:

* AWS
* Rackspace
* Google Cloud Platform
* OpenStack
* ...

Status
======

The solution is still in POC status.

Vocabulary
==========

Service
-------

A service represents a software accessible via either HTTP or TCP such as:

* a database
* a web server
* an application server
* ...

Compute
-------

A compute is a node provider, for example:

* Docker engine: containers as nodes
* AWS: EC2 instances as nodes
* VSphere VCenter: Virtual machines as nodes

Architecture
============

The stack is separated in 5 major components.

.. image:: https://camo.githubusercontent.com/cbc9a64465bef359b03b8d62ebcac9773951f541/68747470733a2f2f7777772e6c7563696463686172742e636f6d2f7075626c69635365676d656e74732f766965772f35353264343663372d666230382d346133342d386262372d3332383930613030633765652f696d6167652e706e67

Each components is powered by one or more tools. As stated in the introduction, the *Skynet* stack aims to be technology agnostic and it has been created with this in mind.

Every component **must be** replaceable.

Access the `current status schema`_.

Service registry
----------------

The *service registry* is in charge of service discovery and centralize service definitions.

It is currently powered by `Consul`_ which provides a DNS service in addition of service discovery.

Compute
-------

The *compute* component is responsible of:

* managing compute resources (containers, virtual machines)
* notifying the service registry of created/updated/deleted resources

It is currently powered by `Docker`_ and `Registrator`_.

**Docker** is used to spin up containers in a quick and easy way and **Registrator** will automatically register/deregister new containers inside the *service registry* component.

Metrics
-------

The *metrics* component retrieves metrics from every other component in the stack.

It is currently powered by `Prometheus`_ which offers a poll based monitoring system. It uses exporter processes to scrap metrics from **Consul** and **HAProxy**.

Load-balancer
-------------

The *load-balancer* component redirects the traffic on the compute resources associated to a service.

It communicates with the *service registry* to dynamically update its configuration.

It is currently powered by `HAProxy`_ to serve the services hosted in a **Docker** compute.

Central processing unit
-----------------------

This component query the *metrics* component and trigger updates in the *service registry* and in the *compute* component to automatically adjust compute resources and service definitions.

It is currently powered by:

* `Central-core`_: a component in charge of managing scaling rules. It uses an adapter to poll metrics from **Prometheus**.
* `Genisys`_: a component in charge of updating the *compute* resources. It uses an adapter to manage **Docker** resources.

How-to
======

Elastic scaling of a web application
------------------------------------

This section will show you how to automatically scale a web application in a Docker compute. The elastic scaling rule will be based on the inbound HTTP traffic of the web application.

You'll learn how to:

* Define a compute in **Genisys**
* Define a service in **Genisys**
* Define an elastic scaling rule in **Central-core**
* Generate some load on your service

Use the following container packaged web application with the solution: `skynet-backend`_

Download and start the *Skynet* stack:

.. code-block:: bash

    $ git clone https://github.com/cyberdyne-corp/skynet.git && cd skynet
    $ docker-compose up

By default, the stack will register a local *Docker* compute in *Genisys* and a service called *skynet-backend* in the *Genisys* connector for Docker.

Have a look at *Prometheus* metrics dashboard to list all available metrics, access it via http://localhost:9090.

**WORK IN PROGRESS**


Blue-green deployment of a Dockerized application
-------------------------------------------------

Use the following container packaged web application with the solution: `skynet-backend`_

**WORK IN PROGRESS**

You can still access the old wiki documentation for more information on blue-green deployment: https://github.com/cyberdyne-corp/skynet/wiki/Blue-green-deployment

.. _Consul: https://www.consul.io/
.. _Docker: https://www.docker.com/
.. _Registrator: https://github.com/gliderlabs/registrator
.. _Prometheus: http://prometheus.io/
.. _HAProxy: http://www.haproxy.org/
.. _Central-core: https://github.com/cyberdyne-corp/central-core
.. _Genisys: https://github.com/cyberdyne-corp/genisys
.. _current status schema: http://goo.gl/UBFueq
.. _skynet-backend: https://github.com/cyberdyne-corp/skynet-backend
