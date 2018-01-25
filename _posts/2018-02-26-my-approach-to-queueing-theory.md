---
layout: post
title: My approach to queuing theory and system modeling
date: 2018-02-26 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling
javascript:
  katex: true
---

My initial need of queuing theory arose when working with distributed and parallel programs as part of my physics researcher. Later as engineer, it became fundamental for modeling distributed applications and system that I started to work with. It also became one of the main sources of inspirations for automation, in where algorithm were derived from relationships originated from queuing theory.

This will be a recurrent topic in this blog. However, I am not planning all one blog after another. I would like to leave some room to add more things as I learn them and I am pretty sure there will be a lot of material about this. Therefore, I decided to double link all these posts so you can always go to the previous and the next post of this series.

I will not discuss or derive all the details about queuing theoretical results, there are lots of good references that do that quite well I am planning to point out. I just want to point out the results I found more useful in practice base on my experience. In particular for this post, I will introduce basic definitions and notation.

The minimal element of queuing theory is a *service center* or *system* that is made of a group of *servers* (cores, CPUs, computer, people, etc) capable to serve *customers* at average rate of \\|\mu\\|. It is important to realize that servers can be anything capable of providing services like people but also computer cores, processors, hosts, clusters, event data center, etc. Moreover, we refer as customers as anything that can consume services such as people, as well processor instructions, processes, programs, etc.

{% include image file="simple-open-queue.svg" %}

Customers arrive to the systems at a average rate \\|\lambda\\| and leaves the system at a rate \\|\mu (n \wedge N)\\|[^1]. If customers find all the servers busy then they wait in the system *queue*. Customers waiting in the queue will be served as soon a server is available. Which customer is served first and how those services are rendered is given by *scheduling policy*. I will be assuming a first-come-first-server (FCFS) policy in where each customer in service prevent its server of providing services to any other waiting customer until completion (known as non-preemptive policy)[^2].

What follows are all parameters and their definition I will be using in future posts:

* \\|q\\|: number of customers in system queue
* \\|n\\|: number of busy servers and also number of served customers for non-preemptive policy.
* \\|p\\|: total number of customer in the system or \\|p = q + n\\|
* \\|s\\|: average service time defined as the inverse of service rate or \\|s = \mu^{-1}\\|

In the next post I will start discussion some basic results that can be derived from the system parameters.

#### References

[^1]: It is common the following notation in queuing theory papers of using \\|x \wedge y = \min(x,y)\\| and \\|x \vee y = \max(x,y)\\|

[^2]: In theory and practice there are other policies, however I will be assuming FCFS and non-preemptive policy, except I say otherwise. A more detail description of scheduling policies can be found at [Performance Modeling and Desing of Computer Systems by Mor Harchil-Balter, part VII.](https://www.amazon.com/Performance-Modeling-Design-Computer-Systems/dp/1107027500)
