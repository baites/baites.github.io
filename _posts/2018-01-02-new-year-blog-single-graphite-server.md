---
layout: post
title: "New Year blog: Single graphite server with grafana"
date: 2018-01-02 18:30:00 -0400
author: Victor E. Bazterra
categories: system-design telemetry graphite grafana ansible
---

Several of my past and current projects require collecting a lot of data that can naturally be mapped as time series. This is how I found out about Graphite, one of the simplest and scalable open-source time-series database[^1].

From my point of view graphite has the following features that makes it very popular:

* Relatively simple design and implementation.
* Because of its underlying simplicity, it can scale well horizontally.
* Terrific API for rendering time series.
* Modular services that allow deploying it in multiple configurations.

IMHO, Graphite down side is due to following issues:

* Hard to install for the first time.
* No direct ways for managing and indexing time series metadata.
* No best deployment configuration, so it take R&D to find the right one.

There are also some features like server-side time series rendering that is up to discussion on how beneficial or scalable really there are. I will not discuss Graphite design choices, because you can learn most of them from a wonderful online resource done by Chris Davis one of Graphite core developers[^2].

People tend to complain a lot about graphite old looking dashboard interface. However, this is easy to fix by using a dedicated front-end application that can use graphite as its back end. In my opinion the prettiest of them all is Grafana that can also be used with other time-series databases[^3]

In this post, I plan to show you one of the many configurations to setup one Graphite server together with Grafana, see figure below:

{% include image file="single-graphite-server.svg" %}

All these services are assumed to be installed in the same host, so it is more a standalone installation that cannot by itself scale horizontally. It is likely, that I will discuss in future post, a configuration that can be scale up horizontal and that is also somewhat highly available(ish).

A summary of the services can be found next:

* **Carbon-cache**: Message-queue like service to collect metric points sent via UDP or TCP and save them in disk using whisper.
* **Whisper**: A library for implementing a file-based time-series database format for graphite.
* **Graphite-web**: Front end distributed with Graphite for showing and rendering time series saved in whisper. It also implements a simple but efficient dashboard to publish a selected number of metrics. User accounts are implemented by [django](https://www.djangoproject.com/) using [mysql](https://www.mysql.com/) as its database.
* **Grafana**: For beautiful dashboards.
* **NGIX**: Proxy to direct traffic to graphite or grafana based on baseurl.
* **Collectl**(optional): For self-monitoring of graphite server, useful to detect when the server is stressed and capacity planning.
* **Logter**(optinal): For self-monitoring of graphite http requests to quantify quality of service.  

Rather explain how to do the installation, I can use a [ansible playbook](https://github.com/graphite-server/ansible) that I prepared as programming assignment for this post[^4]. In particular, this playbook will install my modified version of graphite with some improvements for federated rendering and some extra functions for processing time series[^5].

Finally, I like to state that ansible and similar tools are bringing a small revolution by automating system deployments, and integrating in the same process configuration management. Also, it provides a efficient and functional way of documenting system designs. This a *big added value* people do not discuss often!

#### Rerefences ####

[^1]: Graphite project [source code](https://github.com/graphite-project/), and [documentation](http://graphite-api.readthedocs.io/en/latest/)

[^2]: Chris Davis, [Graphite in The Architecture of Open Source Applications](http://www.aosabook.org/en/graphite.html).

[^3]: [Grafana:The open platform for beautiful analytics and monitoring.](https://grafana.com/):

[^4]: [Automation for everyone with ansible](https://www.ansible.com/)

[^5]: [Graphite-server](https://github.com/graphite-server) is from a relatively old fork of the [graphite-project](https://github.com/graphite-project). I recommend to follow main graphite-project, but for that you will need to change ansible playbook from this blog. Take it as an exercise!
