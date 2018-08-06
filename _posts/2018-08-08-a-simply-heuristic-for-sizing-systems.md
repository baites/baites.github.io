---
layout: post
title: "A simply heuristic for sizing systems"
date: 2018-08-08 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling
javascript:
  katex: true
  pseudocode: true  
---

This post is a continuation of a series of blogs about queueing theory; please see below the section about related posts that belong to this series. The goal of this post is to provide a quick and dirty heuristic when sizing systems. This is a continuation of the previous post ([A common misconception when sizing systems]({% post_url 2018-06-25-a-common-misconception-when-sizing-systems %})) in where I talk about some incorrect heuristics resulting from some misconceptions about how systems behave. In particular, I argued you should be careful in using queue size as indicator of system demand.

As alternative, heuristics derived from looking at number of used servers tend to be safer. In these heuristics the mission is to preserve a number of idle servers ready to provide services to incoming customers. If the added servers are intimidatingly put in use then you should enable more servers  until a targeted number of idle servers is reached. These heuristics therefore provide a prescription about the desirable number of idle servers establishing a provision safety policy against increases of customer demand.

### Fix idle server heuristic

> **Fix idle server heuristic:** increase the number of servers such as preserving a constant number of idle servers. This means that if the initial number of used servers in the system is \\|n_I\\| then the final of servers should be:

<p>%%
N_F = \lceil n_I + \epsilon \rceil
%%</p>

> where \\|\epsilon\\| is a constant representing the fix targeted number of idle hosts.

The value of \\|\epsilon\\| directly controls the number of idle servers in where the aggregated server utilization for this heuristic is given by \\|U \approx (1+\epsilon/n_I)^{-1}\\|. At low values of \\|n_i\\| the server utilization is controlled by \\|\epsilon\\| parameter. Therefore this heuristic is great to set a good quality of service when number of used server is low by fixing the number of idle servers regardless the actual number of busy servers. Although this is wasteful, it is only when there are only a few servers in total. The absolute cost of having those servers is still relatively small.

Eventually server utilization improves as the number of busy servers increases or \\|\lim_{n_I \rightarrow \infty} U = 1\\|. However, at large scale the utilization approach so quickly to 1 that as result the customer quality of service gradually becomes quite poor. The next figure the queue size vs server utilization for a system with initially 1000 servers and an average number delayed customers of 500 (red diagram) in the *M/M/N* queue model[^1]. Because the systems it is very close to saturation the utilization is practically 100% or \\|U \approx 1\\|

{% include image file="mmn-fix-heuristic.svg" scale="70%" %}

In the same figure I show in blue the final state of the same system after adding 10 more servers. Assuming no change in user demand those extra 10 server will be idle resulting in a utilization of \\|U \approx 0.99\\|. The figure shows a significant reduction of delay customer, however, customer services might still be far from ideal because it is expected that on average 51 users waiting in queue at any given time. Therefore at scale, this heuristic produces recommendations that are purely efficient driven at expense of quality of service.

### Constant server utilization heuristic

With the goal of avoiding previous heuristic drawback, I could instead set the number of idle servers proportional to the number of busy servers.

> **Constant server utilization heuristic:** increase the number of servers such as preserving a number of idle servers proportional to the number of initial busy servers. This means that if the initial number of used servers in the system is \\|n_I\\| then the final number of servers should be:

<p>%%
N_F = \lceil n_I + \alpha n_I \rceil
%%</p>

> where \\|\alpha\\| is a parameter that controls the aggregated server utilization given by \\|U \approx (1+\alpha)^{-1}\\|.

This heuristic is designed to preserve the aggregated server utilization constant at any scale. Because this, customer quality of service is guarantee regardless the scale of the system. It is similar to quality-driven regimen defined using queue model with abandonment like *M/M/N + G*[^2]. It is likely commonly in large scale system by using load balancer to equally distribute system utilization between multiple servers. In the aggregated utilization is too high, administrative or automated agents add more servers to the load balancer resource pool.

The only issue with previous recommendation is that at large scale we can increase service utilization and still preserving the overall quality of service. This was the main point on a previous post where I showed at scale systems become more robust against stochastic fluctuation of customer demand, see [Single open queue at scale]({% post_url 2018-04-23-single-open-queue-at-scale %}). For example, the figure below shows the result of applying this heuristic over the same initial system in saturation as the previous section using \\|\alpha = 0.25\\|. As expected the final aggregated utilization is \\|U = 0.8\\| and the mean queue length is practically zero. From the plot, it is easy to see that if we choose to run at a significant high server utilization than 80%, and still keeping the mean number of waiting customers practically to zero.

{% include image file="mmn-fixutil-heuristic.svg" scale="70%" %}

### Square-root heuristic

Therefore the question is, for large systems with large demand, how should we scale the number of idle servers? The answer for this is IMHO the most important asymptotic result in queue theory know the Square Root Rule[^3]. From it I can define the following recommendation.

> **Square-root heuristic:** increase the number of servers such as preserving a number of idle servers proportional to the **square root** of the number of initial busy servers. This means that if the initial number of used servers in the system is \\|n_I\\| then the final number of servers should be:

<p>%%
N_F = \lceil n_I + \beta \sqrt{n_I} \rceil
%%</p>

> where \\|\beta\\| is a parameter that controls what is call provision level safety.

Applying this rule the saturated test system with a \\|\beta = 2.3\\| results in an addition of an extra 73 new servers resulting in a server utilization of \\|U = 0.93\\| with more than half of the time without any waiting customer \\|w = 0.2\\|, see plot below!

{% include image file="mmn-srr-heuristic.svg" scale="70%" %}

Moreover this is robust at scale. For example, let's consider the case in where number of servers is now ten times more or \\|N = 10000\\| and there are \\|5000\\| customers in queue. The square-rule recommendation with the same \\|\beta = 2.3\\| suggest adding an extra 230 servers resulting in a final server utilization of \\|U = 0.98\\| and number of waiting customer of \\|w = 0.5\\| or half of the time the queue is empty. It is important to notice server utilization improves for large \\|n_I\\| as \\|U \approx (1+\beta/\sqrt{n_I})^{-1}\\|.

### Combined heuristic

Can we combined all the into one having the all the benefits without the drawbacks? I think the answer is yes and general for for this *combined heuristic* is as follow:

<p>%%
N_F = \lceil n_I + \max \left\{\epsilon, \alpha n_I \theta(n_I) + \beta \sqrt{n_I} \left[1-\theta(n_I)\right]\right\} \rceil
%%</p>

where the \\|\theta(\cdot)\\| is weighting function such as \\|\theta(0) = 1\\| and \\|\lim_{n \rightarrow \infty}\theta(n) = 0\\| that smoothly transitions between constant utilization heuristic and square-root rule. The simplest choice that comes to mind is the exponential function or \\|\theta(n) = \exp(-n/\eta)\\| in where \eta parameter how fast the transition goes.

Next figure presents the result of applying the heuristics assuming different values for initial number of busy servers \\|0 \leq n_I \leq 10000\\| and using the *M/M/N* queue model to derive the number of waiting customers in queue.

{% include image file="mmn-combined-heuristic.svg" scale="90%" %}

For low values of \\|n_I\\| the recommendations are more wasteful by suggesting to run the system at relatively low utilization. However, it is in this regime in where keeping customers happy is worth the absolute cost of maintaining a small system. As the system scales, the square-rule rule dominate the recommendations increasing overall system utilization by taking of the system economy at scales.

### Caveats and final remarks

#### Program assignment or examples

* [MATLAB code with sizing heuristics](https://github.com/baites/examples/tree/master/analyses/queueing/sizing)

#### Related posts

* [My approach to queuing theory]({% post_url 2018-02-26-my-approach-to-queueing-theory %})
* [Single open queue]({% post_url 2018-04-09-single-open-queue %})
* [Single open queue at scale]({% post_url 2018-04-23-single-open-queue-at-scale %})
* [A common misconception when sizing systems]({% post_url 2018-06-25-a-common-misconception-when-sizing-systems %})

#### References

[^1]: This is the **elbow** curve of death that was introduced in the previous post of this series: [A common misconception when sizing systems.]({% post_url 2018-06-25-a-common-misconception-when-sizing-systems %})
[^2]: Zeltyn, Sergey, and Avishai Mandelbaum. "Call centers with impatient customers: many-server asymptotics of the M/M/n+ G queue." Queueing Systems 51.3-4 (2005): 361-402.
[^3]: The Square Root Rule is such important result that might blog about it in the future. Although this rule can be derived heuristically and it was tested in the field for long time, it took until the following seminar paper to show that the rule asymptotically correct for *M/M/N* queues: Borst, Sem, Avi Mandelbaum, and Martin I. Reiman. "Dimensioning large call centers." Operations research 52.1 (2004): 17-34. For *M/M/n+G* the Square Root Rule defines what is known as Quality and Efficient Driven regime[^2].
