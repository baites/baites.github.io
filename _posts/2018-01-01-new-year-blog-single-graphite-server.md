---
layout: post
title: "New Year blog: Single graphite server with grafana"
date: 2018-01-03 08:00:00 -0400
author: Victor E. Bazterra
categories: system-design telemetry graphite grafana ansible
---

Lots of past and current projects require collecting a lot data that can naturally be mapped as time series. One of the simplest and scalable open-source time-series databases is graphite[^1].

From my point of view graphite has the following features that makes it very popular:

* Relatively simple design and implementation.
* Because of its underlying simplicity it can scale well horizontally.
* Terrific API for rendering time series.
* Very modular allowing multiple configurations.

The down side is on the line of:

* Hard to install for the first time.
* No direct ways of managing time series.
* Very modular therefore take some time to find the right deployment for a application.

There are also some features like rendering time series on the server side that are up to discussion if it is beneficial or not. I will not discuss a lot about graphite design choices because you can learn most of them from a wonderful online resource done by one of the core developer of graphite by Chris Davis[^2].

People tend to complain a lot about graphite old looking dashboard interface. However, this is easy to improve by using a dedicated front-end application that can use graphite as its back end. In my opinion the prettiest of the all is grafana that can also be used with other time-series databases[^3]

In this post I plan to show you one of the many configurations to setup one graphite server together with grafana, see figure below:

{% include image file="single-graphite-server.svg" %}

All this services are assumed to be installed in the same host, so it is more a standalone installation that cannot by itself scale horizontally. It is likely I will discuss more scalable and high-available(ish) solution in other posts.

A summary of the service is the follow:

* **Carbon-cache**: Message queue like service to collect metrics points sent via UDP or TCP and save them in disk using whisper.
* **Whisper**: A library for implementing a file-based time-series database format for graphite.
* **Graphite-web**: Front-end for showing and rendering time series saved in whisper. It also implements a simple but efficient dashboard to publish a selected number of metrics. Also this service supports user accounts as implemented by [django](https://www.djangoproject.com/) using [mysql](https://www.mysql.com/) as its database.
* **Grafana**: For beautiful dashboards.
* **NGIX**: Proxy to direct traffic to graphite or grafana based on baseurl.
* **Collectl**(optional): For self-monitoring of graphite server useful to detect server stress and capacity planning.
* **Logter**(optinal): For self-monitoring of graphite http requests to quantify quality of service.  

Rather explain how to do the installation, I can use the [ansible playbook](https://github.com/graphite-server/ansible) that I prepare as programming assignment for this post[^4]. In particular, this playbook will install my modified version of graphite with some improvement for federated rendering and some extra functions for processing time series[^5].

Ansible and similar tools are bringing a small revolution by automating application deployment, and integrating in the same process configuration management. Also, it provides a efficient way of documenting a system design, a *big added value* people do not tend to speak of that much!

[^1]: Graphite project [source code](https://github.com/graphite-project/), and [documentation](http://graphite-api.readthedocs.io/en/latest/)

[^2]: Chris Davis, [Graphite in The Architecture of Open Source Applications](http://www.aosabook.org/en/graphite.html).

[^3]: [Grafana:The open platform for beautiful analytics and monitoring.](https://grafana.com/):

[^4]: [Automation for everyone with ansible](https://www.ansible.com/)

[^5]: [Graphite-server](https://github.com/graphite-server) is from a relatively old fork of the [graphite-project](https://github.com/graphite-project). I recommend to follow main graphite-project, but for that you will need to change ansible playbook from this blog. Take it as a personal project!
