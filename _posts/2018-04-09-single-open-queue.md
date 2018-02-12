---
layout: post
title: "Single open queue"
date: 2018-04-09 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling
javascript:
  katex: true
---

This blog I am writing more about a simple queue I started in previous blogs, see section related posts. The simplest queue that represent the minimal unit to model large number of systems is the Erlang-C model (aka M/M/N queue)[^1]. This is a particular stochastic model of the queue defined in the previous post[^2] in where it assumes:

* customers arrive at rate \\|\lambda\\| following a Poison process[^3]
* customers service time follow an exponential distribution with rate \\|\mu\\|[^4]

The main input parameters of the model are therefore the number of servers \\|N\\|, the arrival rate \\|\lambda\\|, and the service \\|\mu\\|. One of the most important result of queuing theory is then to derive average for main observable for this model[^5]:

* number of busy server: \\|n = x\\|
* throughput in units of \\|\mu\\|: \\|X = n = x\\|
* server utilization: \\|U = n/N = x/N\\|
* number of customer in queue: %%q = C_N(U) \frac{U}{1-U}%%
* number of customer present in the system: \\|p = q + n\\|
* queue waiting time in units of \\|\mu^{-1}\\|: %%w = C_N(U) \frac{1}{N(1-U)}%%
* total time a customer is in the system or response time units of \\|\mu^{-1}\\|: \\| R = w+1 \\|

All these observable are given by offered load \\|x = \lambda/\mu\\| and Erlang-C function

<p>%%
C_N(U) = \left[ U + (1-U) \frac{N!}{(UN)^N} \sum^{N}_{k=0} \frac{(UN)^k}{k!}\right]^{-1}
%%</p>

that is the probability for a customer to be delayed in the queue upon arrival. This is equivalent to say the probability that the number customer in the system \\|p\\| is larger than number of servers \\|N\\| or \\|\text{Prob}(p > N) = C_N(U)\\|. 

Although the model has three parameters \\|\left(\lambda, \mu, N\right)\\|, its behavior is determine mostly by two independent parameters \\|\left(\lambda/\mu, N\right)\\|, in where \\|\mu\\| is a constant that fix the unit of time.

My goal in this post is to introduce the main results and notation that I will be using when discussing queues. A deeper discussion and deduction of these relationships can be found in references in this post. As program assignment, I implemented a simple [MATLAB function](https://github.com/baites/examples/blob/master/analyses/queueing/MMnQueue/model_mmn_queue.m) to compute model results. I also validate the result from the model against simulation as explain below. Erlang-C function was implemented by Brian Borches and its code can be download from [MathWorks' File Exchange](https://www.mathworks.com/matlabcentral/fileexchange/824-erlang-b-and-c-probabilities?focused=5044423&tab=function).

The way I like to show any system performance is by given the response time \\|\left(R\right)\\| and system throughput \\|\left(X\right)\\| as function of a proxy of the load generated in or injected into the system. In this case of open single queue, I like using the server utilization \\|U\\| as proxy of load. The simplicity of open single queue results implies that throughput and utilization are trivially related by \\|X = N\left(U \wedge 1\right)\\|. This means, that throughput grows as more server are in used until there not more servers. Therefore, the non-trivial result is the response time. The following plot show single queue response time computed using the Erlang-C model and a simulation of a Erlang-C queue.

{% include image file="open-queue-reponse.svg" scale="70%" %}

The simulation was implemented in SimEvent[^6] using a derived model of M/M/1 simulation example[^7]. I modified the model to allow more than one server, and I measured the time takes a customer to enter and exist the system (the response time)[^8]. The following figure shows the resulting SimEvent model after the modifications.

{% include image file="mmn-queuing-system.png" scale="100%" %}

For the simulation tuns, I set the number of servers \\|N = 10\\| and \\|\mu = 1\\|. I scanned the value of \\|\lambda_i = 1 - 10^{-v_i} \\| where \\|v_i = 0.1,0.2,...,1.4\\| for having better resolution at \\|U \approx 1\\|. The simulation is run by 40K time steps and the average response time is used in the plot.

As you can see this simple model match with simulation. From this post forward I will be assuming the validity of the model and the code. What I am planning to discuss next is what is the behavior of a single queue at scale.

#### Related posts

* [My approach to queuing theory]({% post_url 2018-02-26-my-approach-to-queueing-theory %})

#### References

[^1]: [Wikipedia: Erlang-C](https://en.wikipedia.org/wiki/M/M/c_queue)
[^2]: [My approach to queuing theory]({% post_url 2018-02-26-my-approach-to-queueing-theory %})
[^3]: [Wikipedia: Poisson point process](https://en.wikipedia.org/wiki/Poisson_point_process)
[^4]: [Wikipedia: Exponential distribution](https://en.wikipedia.org/wiki/Exponential_distribution)
[^5]: [Performance Modeling and Design of Computer Systems: Queueing Theory in Action](http://www.cs.cmu.edu/~harchol/PerformanceModeling/book.html). [Introduction to Queueing Theory and Stochastic Teletraffic Models](https://arxiv.org/abs/1307.2968). [Performance by Design: Computer Capacity Planning by Example](https://cs.gmu.edu/~menasce/perfbyd/). [An Introduction to Queueing Theory](http://www.springer.com/us/book/9780817684204). And more ...
[^6]: [MathWorks SimEvents](https://www.mathworks.com/products/simevents.html)
[^7]: [M/M/1 Queuing System](https://www.mathworks.com/help/simevents/examples/m-m-1-queuing-system.html)
[^8]: [Measure Point-to-Point Delays](https://www.mathworks.com/help/simevents/ug/measure-point-to-point-delays.html)
