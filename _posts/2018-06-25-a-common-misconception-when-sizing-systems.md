---
layout: post
title: "A common misconception when sizing systems"
date: 2018-06-25 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling
javascript:
  katex: true
  pseudocode: true  
---

* TOC
{:toc}

## Introduction

This post is a continuation of a series of blogs about queueing theory; please see below the section about related posts that belong to this series. The goal of this post is to show some applications of what I introduced in the previous blogs about open queues.

When sizing a system, it is common to describe it as an open queue at first order. In this case, I found it is the common the belief that the number of customers waiting in the queue is a good indicator of demand for resources. I would like to show you this notion is dangerously wrong.

A delayed customer upon arrival means that all servers are busy. If your system is relatively large, say ~100 servers, or so, it is unlikely all servers are working because of stochastic increase in demand. The most likely scenario is, therefore, the system is at capacity. Moreover, the chances the system is at its saturation point at first sign of congestion in the queue increases as the system scale in size.

The whole point in the previous paragraph is reflected in the elbow curve of death[^1]. For this blog, I choose to define the elbow curve as queue size as a function of the server utilization. As I will show (or as already shown in the previous blog) for an M/M/N queue, the queue size is low until the system is at capacity or \\|U \approx 1\\|!

Ignoring for second above objections, for some, it feels natural to size systems using what I will call queue length heuristic.

> **Queue length heuristic:** increase the number of servers by the average customers waiting in the queue. Quantitatively, this means that if the system initially has \\|N_I\\| servers and there are \\|q_I\\| number of customers in the queue, then the new system size should be:

<p>%%
N_F = \lceil N_I + q_I \rceil
%%</p>

I think this heuristic results from thinking that you need an extra server for each customer waiting in the queue.

Using the M/M/N queue model we can analyze the consequences of using this heuristic. Assuming that the demand for services does not change when increasing the size of the system, then the offered load is invariant meaning \\|U_I N_I = U_F N_F\\|, where \\|U_I\\| and \\|U_F\\| are the initial and final server utilization. As a result, we can easily derive the final expected number of customer in the queue after resizing using Erlang-C function introduce in previous blogs:

<p>%%
q_F = C_{N_F}(U_F) \frac{U_F}{1-U_F}
%%</p>

All this depend on knowing the initial utilization \\|U_I\\| as a function of \\|N_I\\| and \\|q_I\\|. There is not direct close form \\|U_I = f(N_I, q_I)\\| in M/M/N model; however, it is easy using the queue size form to numerical obtain the initial utilization \\|U_I\\| by searching for the root of the following function

<p>%%
q_I(1-U_I)/U_I - C_{N_I}(U_I) = 0
%%</p>

If this is too complicated, we can assume that the heuristic will be applied when the system is practically in saturation and therefore \\|U_I \rightarrow 1\\|, resulting in that case that \\|U_F \rightarrow N_I/N_F\\|.

So now I have all the ingredients to understand the consequences of applying the queue size heuristic.  As an example, let's assume that we have an almost saturated system \\|U_I \rightarrow 1\\| with a hundred servers \\|N_I = 100\\| and two hundred customers waiting in queue \\|q_I = 200\\|. The result of applying queue size heuristic can be summarized using the two elbow curves (of death) for initial (red) and final (blue) system configurations. The horizontal and vertical lines show the system initial (red) and last (blue) server utilization and queue sizes.

{% include image file="mmn-queue-size-heuristic.svg" scale="70%" %}

As expected, the elbow curve does not change much after the addition of the extra 200 servers. The fact the curve is the almost the same is because with at 100 servers is close to the asymptotic limit and the addition of extra servers will squeeze the curve closer to the asymptote at \\|U = 1\\|. Because the system is initially saturated, then \\|U_F \approx N_I/N_F = 1/3\\|. As a result, the final configuration has, for the most part, an empty queue as expected, at the cost of having hundreds of servers running under low utilization!

Do, does queue size heuristic work? Imagine the following scenario. You are lucky enough to be in an organization that is growing, but you are using the queue size heuristic for sizing your organization infrastructure. First, you wait until there are some signs of congestion in the queue before taking any action. But at that point, your system is at capacity and users are experiencing significant and non-linear delays at sightless changes in demand. Now, a few painful months goes by, and you procure new resources reducing the waiting time to practically zero at the expense of underutilized your system. Now, users are happy, but uncertainty not those stakeholders paying the bills because of the extra capital and operational expenses. Assuming constant growth eventually the system will be in used close to 100% starting the whole cycle aching again.

In this scenario, the queue size heuristic works somewhat on average in the long term under the assumption of constant growth. However, it introduces incredibly wasteful periods because of the delay suffer by users when the system is close to be at capacity, and those long months when the system is underutilized before demand catches up.

For comparison, it is easy to compute a more efficient solution in the case that M/M/N model is good enough for your system. Let's define first the *inverse* of the Erlang-C function or \\|C^{-1}(P,x)\\| as the *minimal* number of servers such the Erlang-C probability is equal or less than input value \\|P\\| in an M/M/N system with offered load \\|x\\|. Because I am assuming the offered load is invariant under system resizing (aka no change in demand), then \\|x = U_I N_I \approx N_I\\| when the initial system configuration is borderline to saturation.

Let's set as a goal to have an almost empty queue after resizing the system. Therefore, arbitrarily I choose the average number of customer waiting in the queue is \\|q_F \approx 0.5\\|. By ergodicity property of M/M/N model, this is equivalent to say on average half of the time the queue is empty. Now, there is the issue that to compute the final number of servers \\|N_F\\|, I need the final probability of a customer to be delayed given by \\|P = q_F(1-U_F)/U_F\\| where \\|U_F = x/N_F\\|, meaning that for this I need to know the value of \\|N_F\\|, that is the value I wanted to compute in the first place! This conundrum can be solved by numerical solving these different equations in a self-consistent way as shown the pseudocode below and the actual [MATLAB code one of my repo](https://github.com/baites/examples/blob/master/analyses/queueing/sizing/mmn_exact_size.m).

{% include pseudocode id="CloseFormV2" code="
\begin{algorithm}
\caption{Pseudocode for MMNExactSize}
\begin{algorithmic}
\FUNCTION{MMNExactSize}{$q_F$, $U_I$, $U_F$}
    \STATE $x = U_I N_I$
    \STATE $N_F = 1.1x$
    \WHILE{True}
        \STATE $U_F = x/N_F$
        \STATE $P = q_F(1-U_F)/U_F$
        \STATE $N = C^{-1}(P,x)$
        \IF{$N == N_F$ or $N+1 == N_F$}
            \RETURN $N$
        \ENDIF
    \ENDWHILE
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
"%}

Running this algorithm that I call **MMNExactSize**, I found I need to add only an extra **16** servers (instead of **200** as the queue size heuristic suggests) so the queue is empty half of the time with an average server utilization of **~86%** (instead of **33%** as result to use queue size heuristic)! The initial and final configuration is illustrated in the next plot.

{% include image file="mmn-queue-size-exact.svg" scale="70%" %}

So be careful with your intuition when working with saturated queues. Do not forget that when your system is close to its saturation point, *your are face to face against the elbow curve of death*.

## Program assignment or examples

* [MATLAB code with sizing heuristics](https://github.com/baites/examples/tree/master/analyses/queueing/sizing)

## Related posts

* [My approach to queuing theory]({% post_url 2018-02-26-my-approach-to-queueing-theory %})
* [Single open queue]({% post_url 2018-04-09-single-open-queue %})
* [Single open queue at scale]({% post_url 2018-04-23-single-open-queue-at-scale %})

## References

[^1]: The **elbow** curve name came from a great post by Neil Gunther [Hockey, Elbow and, Other Response Time Injuries](http://perfdynamics.blogspot.com/2015/07/hockey-elbow-and-other-response-time.html). I just add the **death** part to make clear it would be safer for your career that the system you are managing is away from it!
