---
layout: post
title: "A simple heuristic for sizing systems"
date: 2018-08-08 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling queuing-theory-series
javascript:
  katex: true
  pseudocode: true
---

| This blog is part of a series dedicated to queuing theory. [In the Series page you can find all the posts of the series]({{ 'series#queuing-theory-series' | relative_url}} ). |

* TOC
{:toc}

# Introduction

This post is a continuation of a series of blogs about queueing theory; please see below the section about related posts that belong to this series. The goal of this post is to provide a quick and dirty heuristic when sizing systems, as a complement of my previous entry ([A common misconception when sizing systems]({% post_url 2018-06-25-a-common-misconception-when-sizing-systems %})) in where I talk about some incorrect heuristics that can be derived from misconceptions about how systems behave. In particular, I argued you should be careful in using queue size as an indicator of system demand.

As an alternative, heuristics based on the number of used servers tend are safer. In these heuristics, the mission is to preserve some available servers ready to provide services to incoming customers. If the added servers are intimidatingly put in use, then you should enable more servers until reaching the targeted number of available servers. These heuristics, therefore, provide a prescription about the desirable number of standby servers establishing a provision safety policy against sudden increases in customer demand.

# Fix idle server heuristic

{% include statement/definition name='Fix idle server heuristic' %}
increase the number of servers such as preserving a constant number of available servers, meaning that if the initial number of used servers in the system is $n_I$ then the final of servers should be:

$$
N_F = \lceil n_I + \epsilon \rceil
$$

where $\epsilon$ is a constant representing the fix targeted number of available hosts.
{% include statement/end %}

The value of $\epsilon$ directly controls the number of available servers. The aggregated server utilization for this heuristic is given by $U \approx (1+\epsilon/n_I)^{-1}$. At low values of $n_i$ the server utilization is controlled by $\epsilon$ parameter. Therefore this heuristic is great to set a good quality of service when the number of the used servers is low, by fixing the number of idle servers regardless of the actual number of busy servers. Although this is wasteful at low values of $n_I$, the absolute cost of supporting only a few servers is still relatively small.

Eventually server utilization improves as the number of busy servers increases or $\lim_{n_I \rightarrow \infty} U = 1$. However, at a large scale, the utilization approach so quickly to 1 that the customer quality of service gradually might become quite poor. The next figure the queue size vs. server utilization for a system with initially 1000 servers and an average number delayed customers of 500 (red diagram) in the *M/M/N* queue model[^1]. Because the systems it is very close to saturation the utilization is practically 100% or $U \approx 1$

{% include image file="mmn-fix-heuristic.svg" scale="70%" %}

In the same figure, I show in blue the final state of the same system after adding 10 more servers. Assuming no change in user demand, those extra 10 servers are available resulting in a total server utilization of $U \approx 0.99$. From the figure, we can expect a significant reduction of delay customer. However, customer services might still be far from ideal because on average 51 users are waiting in the queue at any given time. Therefore at scale, this heuristic produces recommendations that are purely efficient driven at the expense of customer quality of service.

# Constant server utilization heuristic

With the goal of avoiding previous heuristic drawback, I could instead set the number of available servers proportional to the number of busy servers.

{% include statement/definition name='Constant server utilization heuristic' %}
increase the number of servers such as preserving many available servers proportional to the number of the initial number of busy servers, meaning that if the initial number of used servers in the system is $n_I$ then the final number of servers should be:

$$
N_F = \lceil n_I + \alpha n_I \rceil
$$

where $\alpha$ is a parameter that controls the aggregated server utilization given by $U \approx (1+\alpha)^{-1}$.
{% include statement/end %}

This heuristic preserves the aggregated server utilization constant for any number of servers. Because of this, customer quality of service is guaranteed regardless of the scale of the system. This recommendation is similar to quality-driven regimen defined using queue model with abandonment like *M/M/N + G*[^2].

This heuristic is effectively used in practice when using a load balancer to distribute system utilization equally between multiple servers. If the aggregated utilization is too high, administrator or automated agents add more servers to the load balancer resource pool.

One issue with the previous recommendation at scale is that it is possible to increase service utilization and still preserve the overall quality of service. I made this point on a previous post where I showed systems at scale become more robust against stochastic fluctuation of customer demand, see [Single open queue at scale]({% post_url 2018-04-23-single-open-queue-at-scale %}). For example, the figure below presents the result of applying this heuristic over the same initial system in saturation as the previous section using $\alpha = 0.25$. As expected, the final aggregated utilization is $U = 0.8$ and the mean queue length is practically zero. However, from the plot, it is also easy to see that running at a significant high server utilization can keep the mean number of waiting customers still close to zero.

{% include image file="mmn-fixutil-heuristic.svg" scale="70%" %}

# Square-root heuristic

Therefore the question is, for large systems with large demand, how should we scale the number of available servers? The answer for this is IMHO an essential asymptotic result in queue theory know the Square Root Rule[^3]. From it, I can come up with the following recommendation.

{% include statement/definition name='Square-root heuristic' %}
increase the number of servers such as preserving many available servers proportional to the **square root** of the number of initial busy servers, meaning that if the initial number of used servers in the system is $n_I$ then the final number of servers should be:

$$
N_F = \lceil n_I + \beta \sqrt{n_I} \rceil
$$

where $\beta$ is a parameter that controls service grade.
{% include statement/end %}

Applying this rule the saturated test system with a $\beta = 2.3$ results in an addition of an extra 73 servers resulting in a server utilization of $U = 0.93$. The mean number waiting in the queue is $w = 0.2$ meaning more than half of the time the queue is empty, see plot below!

{% include image file="mmn-srr-heuristic.svg" scale="70%" %}

As added value this recommendation is robust at scale. For example, let's consider the case in where number of servers is now ten times more or $N = 10000$ and there are $5000$ customers in queue. The square-rule recommendation with the same $\beta = 2.3$ suggest adding an extra 230 servers. As result the new server utilization is now $U = 0.98$ and the mean number of waiting customers is $w = 0.5$ or half of the time the queue is empty. It is important to notice that the server utilization improves for large $n_I$ as $U \approx (1+\beta/\sqrt{n_I})^{-1}$.

# Combined heuristic

Can we combined all the into one having the all the benefits without the drawbacks? I think the answer is yes and general for I can write this *combined heuristic* as follow:

$$
N_F = \lceil n_I + \max \left\{\epsilon, \alpha n_I \theta(n_I) + \beta \sqrt{n_I} \left[1-\theta(n_I)\right]\right\} \rceil
$$

where the $\theta(\cdot)$ is weighting function such as $\theta(0) = 1$ and $\lim_{n \rightarrow \infty}\theta(n) = 0$ that produces a smoothly between constant utilization heuristic and square-root rule. The simplest choice for $\theta(n)$ that comes to mind is the exponential function or $\theta(n) = \exp(-n/\eta)$ in where \eta parameter set how fast the transition is done.

Next figure presents the result of applying the heuristics assuming different values for the initial number of busy servers $0 \leq n_I \leq 10000$ and using the *M/M/N* queue model to derive the number of customers waiting in the queue. I choose as parameter values $\epsilon = 10$, $\alpha = 0.25$, $\beta = 2.3 $, and $\eta = 200$.

{% include image file="mmn-combined-heuristic.svg" scale="90%" %}

For low values of $n_I$, the recommendations are more wasteful by suggesting to run the system at relatively low utilization. However, it is in this regime in where keeping customers happy is worth the cost of maintaining an underutilized but small system. As the system scales, the square-rule rule becomes the dominant component of the recommendation increasing overall system utilization by taking advantage of the system economy at scales.

# Caveats and final remarks

The results showed in the last graph are valid for a *M/M/N* queue. Although the heuristic might work for a queue with different stochastic properties than *M/M/N*, the parameters of the combined heuristic need to be adjusted using other stochastic models or by running simulations. Also, I use results assuming queues are in their steady states. If the demand change over the time, the conclusions are still valid if the typical timescale of this variation is longer than the time that takes for the queue to reach a steady-state equilibrium.

# Program assignment or examples

* [MATLAB code with sizing heuristics](https://github.com/baites/examples/tree/master/analyses/queueing/sizing)

# References

[^1]: This is the **elbow** curve of death that was introduced in the previous post of this series: [A common misconception when sizing systems.]({% post_url 2018-06-25-a-common-misconception-when-sizing-systems %})
[^2]: Zeltyn, Sergey, and Avishai Mandelbaum. "Call centers with impatient customers: many-server asymptotics of the M/M/n+ G queue." Queueing Systems 51.3-4 (2005): 361-402.
[^3]: The Square Root Rule is such an important result that might blog about it in the future. Although this rule was known and tested in the field for a long time, it took until the following seminar paper to show that the rule asymptotically correct for *M/M/N* queues: Borst, Sem, Avi Mandelbaum, and Martin I. Reiman. "Dimensioning large call centers." Operations research 52.1 (2004): 17-34. For *M/M/n+G* the Square Root Rule defines what is known as the Quality and Efficient Driven regime[^2]. I also recently found a blog discussing the rule [The Square Root Staffing Law](https://www.xaprb.com/blog/square-root-staffing-law/).
