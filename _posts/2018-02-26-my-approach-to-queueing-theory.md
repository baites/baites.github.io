---
layout: post
title: My approach to queuing theory
date: 2018-02-26 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling queuing-theory-series
javascript:
  katex: true
---

| This blog is part of a series dedicated to queuing theory. [In the Series page you can find all the posts of the series]({{ 'series#queuing-theory-series' | relative_url}} ). |

My initial need of queuing theory arose when working with distributed and parallel programs as part of my physics researcher. Later as an engineer, it became fundamental for modeling distributed applications and systems in my projects. It also became one of the primary sources of inspirations for automation, in where the algorithm was derived from relationships originated from queuing theory.

This post subject will be a recurrent topic in this blog. However, I am not planning to write about it one blog after another. I would like to leave some room for adding more things as I learn them, and I am pretty sure there will be a lot of material about this. Therefore, I will occasionally be writing about this topic, and linking all these posts as I go along, so you can always go to the previous posts of this series.

I will not discuss or derive all the details about queuing theoretical results; there are lots of excellent references that do that quite well that I am planning to point out. I just want to tell you about the results I found more useful in practice base on my experience. In particular, for this post, the goal is just to introduce basic definitions and notation.

The minimal element of queuing theory is a *service center* or *system* that is made of a group of *servers* (cores, CPUs, computer, people, etc.) capable of serving *customers* at an average rate of $\mu$. It is important to realize that servers can be anything capable of providing services like people but also computer cores, processors, hosts, clusters, event data center, etc. Moreover, I refer to customers as anything that can consume services such as people, as well processor instructions, processes, programs, etc.

{% include image file="simple-open-queue.svg" %}

Customers arrive to the systems at a average rate $\lambda$ and leaves the system at a rate $\mu (n \wedge N)$[^1]. If customers find all the servers busy, then they wait in the system *queue*. Customers waiting in the queue will be served as soon a server is available. Which customer is served first and how those services are rendered is given by *scheduling policy*. I will be assuming a first-come-first-server (FCFS) policy, plus the fact each customer in service prevent its server of providing services to any other waiting customer until completion (known as non-preemptive policy)[^2].

What follows are all parameters and their definition, that I am planning to use in future posts:

* $q$: number of customers in system queue
* $n$: number of busy servers and also number of served customers for non-preemptive policy.
* $p$: total number of customers in the system or $p = q + n$
* $s$: average service time defined as the inverse of service rate or $s = \mu^{-1}$

In the next post, I will start discussing some primary results that can be derived from these parameters.

# References

[^1]: It is common the following notation in queuing theory papers of using $x \wedge y = \min(x,y)$ and $x \vee y = \max(x,y)$

[^2]: In theory and practice there are other policies; however I will be assuming FCFS and non-preemptive policy, except I say otherwise. A more detail description of scheduling policies can be found at [Performance Modeling and Desing of Computer Systems by Mor Harchil-Balter, part VII.](https://www.amazon.com/Performance-Modeling-Design-Computer-Systems/dp/1107027500)
