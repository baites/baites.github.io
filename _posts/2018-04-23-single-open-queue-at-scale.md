---
layout: post
title: "Single open queue at scale"
date: 2018-04-23 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling
javascript:
  katex: true
---

IMHO probability and statistics power comes mostly from its asymptotic properties[^1]. The law of large numbers, central limit theorem,... provide examples of what I consider one of the few nature's free lunch: that some complicated interacting systems can be modeled masochistically and therefore they present simpler regularities at scale[^2].

In the case of queuing theory, the development its asymptotic properties is rather recent[^3]. I am not sure about the results themselves (some known for quite some time) but rather the emphasis of their importance, since the begin of the era of very large systems with the creation of the Internet.

One seminar result for simple open queue model \\| M/M/N \\| is that the number of customers in a system can be approximated by[^4]

<p>%%
p_{\eta} \approx \eta p^{(0)} + \eta^{1/2}p^{(1)} + O(1)
%%</p>

where \\|\eta\\| is scale index that describe a continues of systems with offered load \\|x_{\eta} = \eta x_1 \\| and with a number of servers \\|N_{\eta} = \eta N_1\\|. The notation \\| p_{\eta} \\| represents the number of customer (queued plus served) in a \\|\eta \\|-indexed system[^5]. The first term \\| p^{(0)} \\| is known as *fluid approximation* and it is deterministic in nature (meaning is not stochastic). The second term \\|p^{(1)}\\| is called *diffusion approximation* that is a stochastic process mostly following Brownian motion[^6].

Now, it is important to notice that server utilization \\|U = x_1/N_1 \\| is scale invariant. Therefore, the previous statement is equivalent to say that the behavior of a single open queue is mostly given by the fluid term \\| p^{(0)} \\| within an error \\| O \left(1/\sqrt{N}\right) \\|, in the limit of \\|x \rightarrow \infty\\| and \\|N \rightarrow \infty\\| such as \\|U = \text{const}\\|. Therefore at scale a simple open queue behaves approximately in a deterministic way, and this approximation improves as the larger the system becomes.

A simple queue with deterministic customer arrival rate and number of servers so that system utilization is fixed for some value \\|U < 1\\| will have a number customer \\| p^{(0)} = UN \\|. This means that all the customer will be in service and therefore no customer will be waiting in the queue of the system, or the queue length and waiting time will be zero!

Proving this is not easy and that is why reference the papers reference [4] are so important. However, I can offer a "slightly" easier way to show this point only for a single open queue. For this case it is enough to figure out what happen to the probability of a customer to be delayed upon arrival, or equivalent what happen with Erlang-C function \\|C_N(U)\\| in the asymptotic limit \\|x \rightarrow \infty\\| and \\|N \rightarrow \infty\\| such as \\|U = \text{const}\\| (see previous blog [Single open queue]({% post_url 2018-04-09-single-open-queue %})). This limit is known also as one heavy traffic condition[^7].

Rather getting the asymptotic limit of \\|C_N(U)\\|, it would be easier to derive an asymptotic limit for Erlang C upper bound. The problem is that getting an upper bound Erlang C is not a trivial task. Likely, there is large volume of superb work on queuing theory that is not always that well known. An example is the work by Janssen et.al., in where bounds and asymptotic expansion for Erlang C is developed[^8]. In particular, these bounds are somewhat trivial results derived from early work by the authors, in where they find tight bounds for Erlang B function[^9].

But before using these bounds to understand asymptotic limit of a single queue, it would be nice to known high tight they really are. The first plot of the figure below show the Erlang C function together with its lower and upper bound derived by Janssen et.al. for \\|N = 10\\|[^8]. The other plots in the same figure show the resulting number of customers in queue and their average waiting time using the original Erlang-C function as well its lower and upper bound. As you can see the bound are so tight that can be used basically as a very good approximated implementation for \\|C_N(U)\\|. [Here a link to the scripts for computing and generating the graph written in MATLAB](https://github.com/baites/examples/blob/master/analyses/queueing/MMnQueue/show_erlangc_tight_bounds.m).

{% include image file="erlangc-tight-bound.svg" scale="100%" %}

Using upper tight bound (eq. 2.3 in reference [^8]), we can derived the following looser but simpler upper bound to Erlang C function

<p>%%
\begin{aligned}
    C_N(U) &\leq \left[\frac{2-U}{3} + (1 - U)\sqrt{N}\frac{\Phi(\alpha)}{\phi(\alpha)}\right]^{-1}\\
    &< \frac{1}{\sqrt{N}}\frac{\phi(\alpha)}{(1 - U)\Phi(\alpha)}
\end{aligned}
%%</p>

where \\|\alpha = \sqrt{-2N (1-U + \ln{U})}\\|, \\|\phi(x) = \left(2\pi\right)^{-1/2} e^{-x^2/2}\\| is the normal density distribution center in zero and unitary variance, and \\|\Phi(x)\\| is its the cumulative distribution function[^10]. The simpler and looser upper bound is plotted and compare against both Erlang C function and its tight upper bound in the next graph, [where here it is a link to MATLAB script that compute and generate the plot](https://github.com/baites/examples/blob/master/analyses/queueing/MMnQueue/show_erlangc_upper_bounds.m). This shows that for any level utilization \\|U < 1\\|, the Erlang C function and therefore, the number of customers in the system queue goes to zero or \\|q \rightarrow 0\\|, and this happens at a rate of at least \\|1/\sqrt{N}\\| when \\|N \rightarrow \infty\\|.

{% include image file="erlangc-loose-bound.svg" scale="50%" %}

We can directly assess this limit by computing the delay probability, the number of customer in the queue, and their average waiting time for different number of servers \\| N = 1, 10, 100, 1000 \\|. This is done in the figure below, and [here it is the link of the MATLAB code generating the figure](https://github.com/baites/examples/blob/master/analyses/queueing/MMnQueue/show_erlangc_asympt.m).

{% include image file="erlangc-asymptotics.svg" scale="100%" %}

This graph shows in my opinion one of the clearest academical example of economy of scale. The larger the system becomes, then lower is the waiting time at any level of utilization. For a very large system, there will not basically waiting until reaching very high level of utilization!

In conclusion, nature is kind enough to reward you IF you manage to conquer running a system at scale.

#### Related posts

* [My approach to queuing theory]({% post_url 2018-02-26-my-approach-to-queueing-theory %})
* [Single open queue]({% post_url 2018-04-09-single-open-queue %})

#### References

[^1]: [Wikipedia: Asymptotic theory (statistics).](https://en.wikipedia.org/wiki/Asymptotic_theory_(statistics))
[^2]: This has inspired many people including in the arts. If you have not read [Isaac Asimov foundation books](https://en.wikipedia.org/wiki/Foundation_series) you should!!! If you do not have the time and you need a shot version, then read [The End of Eternity](https://en.wikipedia.org/wiki/The_End_of_Eternity). At the end, we all want somewhat inspire to be [psychohistorians](https://www.theguardian.com/books/2012/dec/04/paul-krugman-asimov-economics).
[^3]: I do not know enough to review literature. In any case, I am qualifying more about the emphasis of the importance of these results because of the creation of larger computer systems.
[^4]: Mandelbaum, Avi, William A. Massey, and Martin I. Reiman. "Strong approximations for Markovian service networks." Queueing Systems 30.1-2 (1998): 149-201.[[link](https://link.springer.com/article/10.1023/A:1019112920622)]. Mandelbaum, Avi, et al. "Queue lengths and waiting times for multiserver queues with abandonment and retrials." Telecommunication Systems 21.2-4 (2002): 149-171. [[link](https://link.springer.com/article/10.1023/A:1020921829517)].
[^5]: Notation I am using is the same as defined in previous post related to queuing theory, see section about related posts.
[^6]: This result was derived for way more generic case of a time-varying queue \\|M(t)/M(t)/N(t)\\|. In this post though, we will concentrate in the implications for the system steady state.
[^7]: [Wikipedia: Heavy traffic approximation](https://en.wikipedia.org/wiki/Heavy_traffic_approximation). Gautam, Natarajan. Analysis of queues: methods and applications. CRC Press, 2012. [[link](https://www.crcpress.com/Analysis-of-Queues-Methods-and-Applications/Gautam/p/book/9781138073067)]
[^8]: Janssen, A. J. E. M., J. S. H. Van Leeuwaarden, and Bert Zwart. "Refining square-root safety staffing by expanding Erlang C." Operations Research 59.6 (2011): 1512-1522.([link](https://pubsonline.informs.org/doi/abs/10.1287/opre.1110.0991))
[^9]: Janssen, Augustus Josephus Elizabeth Maria, J. S. H. Van Leeuwaarden, and Bert Zwart. "Gaussian expansions and bounds for the Poisson distribution applied to the Erlang B formula." Advances in Applied Probability 40.1 (2008): 122-143.([link](https://www.cambridge.org/core/journals/advances-in-applied-probability/article/gaussian-expansions-and-bounds-for-the-poisson-distribution-applied-to-the-erlang-b-formula/76DB4F08E5A5DE90D85A90E9D0788DA7#))
[^10]: [Wikipedia: Normal distribution](https://en.wikipedia.org/wiki/Normal_distribution).