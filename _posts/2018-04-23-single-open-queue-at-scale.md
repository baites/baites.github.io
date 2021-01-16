---
layout: post
title: "Single open queue at scale"
date: 2018-04-23 08:00:00 -0400
author: Victor E. Bazterra
categories: queuing-theory system-modeling queuing-theory-series
javascript:
  katex: true
---

| This blog is part of a series dedicated to queuing theory. [In the Series page you can find all the posts of the series]({{ 'series#queuing-theory-series' | relative_url}} ). |

This post is a continuation of a series of blogs about queueing theory; please see below the section about related posts that belong to this series.

IMHO probability and statistics power comes mostly from its asymptotic properties[^1]. The law of large numbers, central limit theorem, etc. provide examples of what I consider one of the few nature's free lunches: that some complicated systems can be modeled stochastically and therefore they present simpler regularities at scale[^2].

In the case of queuing theory, the development its asymptotic properties are somewhat recent[^3]. I am not sure about the results themselves (some known for quite some time) but rather the emphasis of their importance, since the beginning of the era of vast IT systems with the creation of the Internet.

One seminar result when apply to the simple open queue model \\| M/M/N \\| is that the number of customers in a system can be approximated by[^4]

<p>%%
p_{\eta} \approx \eta p^{(0)} + \eta^{1/2}p^{(1)} + O(1)
%%</p>

where \\|\eta\\| is scale index that describe a continues of systems with offered load \\|x_{\eta} = \eta x_1 \\| and with a number of servers \\|N_{\eta} = \eta N_1\\| for some orignal value of offered load \\|x_1\\| and number of servers \\|N_1\\|. The notation \\| p_{\eta} \\| represents the number of customer in the system (queued plus served) in a \\|\eta \\|-scaled system[^5]. The first term \\| p^{(0)} \\| is known as *fluid approximation* and it is deterministic in nature (meaning it is not stochastic). The second term \\|p^{(1)}\\| is called *diffusion approximation* that is a stochastic process following Brownian motion[^6].

Now, it is important to notice that server utilization \\|U = x_1/N_1 \\| is scale invariant. Therefore, in the limit of a queue at large scale \\|\eta \rightarrow \infty\\| with some constant utilization \\|U = \text{const}\\|, the previous statement says that the behavior of a single open queue is mostly given by the fluid term \\| p^{(0)} \\| within an error \\| O \left(1/\sqrt{\eta}\right) = O\left(1/\sqrt{N}\right)\\|. Therefore at scale a simple open queue behaves approximately in a deterministic way, and this approximation improves as the larger the system becomes.

For a simple queue with deterministic customer arrival rate, a fix number of servers \\| N\\|, and given system utilization \\|U < 1\\| number customers in the system then is \\| p^{(0)} = UN \\|. This number implies that all the customer will be in service and therefore no customer is waiting in the queue of the system, or the queue length and waiting time is zero!

However, a small and non-deterministic system is more susceptible to stochastic fluctuations that momentarily increases the number of customers above the number available servers. In this scenario there a significant chance for a customer to be delayed in the queue, and in aggregation, there would be a non zero average waiting time.

Proving this simple statement is not easy, and it is done for very generic case in the seminar paper[^4]. However, I can offer you an easier way to show this point in the case of a single open queue of type M/M/N. For this case it is enough to figure out what happen to the probability of a customer to be delayed upon arrival, or equivalent what happen with Erlang-C function \\|C_N(U)\\| in the asymptotic limit \\|x \rightarrow \infty\\| and \\|N \rightarrow \infty\\| such as \\|U = \text{const}\\| (see previous blog if you could not follow last sentence: [Single open queue]({% post_url 2018-04-09-single-open-queue %})). This limit is also known as heavy traffic condition[^7].

Instead of getting the asymptotic limit of \\|C_N(U)\\|, it is easier to derive an asymptotic limit for Erlang C upper bound. The problem is that getting an upper bound Erlang C is not a trivial task. Likely, there is a considerable volume of superb work on queuing theory that is not always that well known (at least by me). An example of this is a work by Janssen et al., in where bounds and asymptotic expansion for Erlang C are developed[^8]. In particular, these bounds are direct results derived from early work by the authors, in where they find tight bounds for Erlang B function[^9].

But before using these bounds to understand the asymptotic limit of a single queue, it would be nice to know how tight these bounds are. The first plot of the figure below shows the Erlang C function together with its lower and upper bound derived by Janssen et al. for \\|N = 10\\|[^8]. The other plots in the same figure show the resulting number of customers in the queue and their average waiting time using the original Erlang-C function as well it's lower and upper bound. As you can see the bound values are so tight that can be used as an excellent approximation of \\|C_N(U)\\|. [Here a link to the scripts for computing and generating the graph written in MATLAB](https://github.com/baites/examples/blob/master/analyses/queueing/mmnqueue/show_erlangc_tight_bounds.m).

{% include image file="erlangc-tight-bound.svg" scale="100%" %}

Using upper tight bound (eq. 2.3 in reference [^8]), I can derive the following looser but simpler upper bound to Erlang C function

<p>%%
\begin{aligned}
    C_N(U) &\leq \left[\frac{2-U}{3} + (1 - U)\sqrt{N}\frac{\Phi(\alpha)}{\phi(\alpha)}\right]^{-1}\\
    &< \frac{1}{\sqrt{N}}\frac{\phi(\alpha)}{(1 - U)\Phi(\alpha)}
\end{aligned}
%%</p>

where \\|\alpha = \sqrt{-2N (1-U + \ln{U})}\\|, \\|\phi(x) = \left(2\pi\right)^{-1/2} e^{-x^2/2}\\| is the normal density distribution center in zero and unitary variance, and \\|\Phi(x)\\| is its the cumulative distribution function[^10]. The simpler and looser upper bound is plotted and compare against both Erlang C function and its tighter upper bound in the next graph, [where here it is a link to MATLAB script that compute and generate the plot](https://github.com/baites/examples/blob/master/analyses/queueing/mmnqueue/show_erlangc_upper_bounds.m). This shows that for any level utilization \\|U < 1\\|. Therefore, this upper bound shows that the Erlang C function and as a consequence the number of customers in the system queue goes to zero or \\|q \rightarrow 0\\|, and this happens at a rate of at least \\|1/\sqrt{N}\\| when \\|N \rightarrow \infty\\|.

{% include image file="erlangc-loose-bound.svg" scale="50%" %}

We can directly assess this limit by computing the delay probability, the number of customers in the queue, and their average waiting time for a different number of servers \\| N = 1, 10, 100, 1000 \\|. I do this in the figure below, and [here it is the link of the MATLAB code generating the figure](https://github.com/baites/examples/blob/master/analyses/queueing/mmnqueue/show_erlangc_asympt.m).

{% include image file="erlangc-asymptotics.svg" scale="100%" %}

This graph shows, in my opinion, one of the nicest academical examples of economy of scale. The larger the system becomes, the lower is the average waiting time at any level of utilization. For a vast system, there is almost no waiting until reaching a very high level of utilization!

In conclusion, it seems that nature is kind enough to reward you IF you manage to conquer running a system at scale. This is because the large a system becomes, the less sensitive is to stochastic fluctuations.

# Program assignment or examples

* [M/M/N queues](https://github.com/baites/examples/tree/master/analyses/queueing/mmnqueue)

# References

[^1]: [Wikipedia: Asymptotic theory (statistics).](https://en.wikipedia.org/wiki/Asymptotic_theory_(statistics))
[^2]: This has inspired many people including in the arts. If you have not read [Isaac Asimov foundation books](https://en.wikipedia.org/wiki/Foundation_series) you should!!! If you do not have the time and you need a short version, then read [The End of Eternity](https://en.wikipedia.org/wiki/The_End_of_Eternity). In the end, we all want somewhat inspire to be [psychohistorians](https://www.theguardian.com/books/2012/dec/04/paul-krugman-asimov-economics).
[^3]: I do not know enough to review literature. In any case, I am qualifying more about the emphasis on the importance of these results because of the creation of larger computer systems.
[^4]: Mandelbaum, Avi, William A. Massey, and Martin I. Reiman. "Strong approximations for Markovian service networks." Queueing Systems 30.1-2 (1998): 149-201.[[link](https://link.springer.com/article/10.1023/A:1019112920622)]. Mandelbaum, Avi, et al. "Queue lengths and waiting times for multiserver queues with abandonment and retrials." Telecommunication Systems 21.2-4 (2002): 149-171. [[link](https://link.springer.com/article/10.1023/A:1020921829517)].
[^5]: Notation I am using is the same as defined in the previous post related to queuing theory, see the section about related posts.
[^6]: This result was derived from way more generic case of a time-varying queue \\|M(t)/M(t)/N(t)\\|. In this post though, we will concentrate on the implications for the system steady state.
[^7]: [Wikipedia: Heavy traffic approximation](https://en.wikipedia.org/wiki/Heavy_traffic_approximation). Gautam, Natarajan. Analysis of queues: methods and applications. CRC Press, 2012. [[link](https://www.crcpress.com/Analysis-of-Queues-Methods-and-Applications/Gautam/p/book/9781138073067)]
[^8]: Janssen, A. J. E. M., J. S. H. Van Leeuwaarden, and Bert Zwart. "Refining square-root safety staffing by expanding Erlang C." Operations Research 59.6 (2011): 1512-1522.([link](https://pubsonline.informs.org/doi/abs/10.1287/opre.1110.0991))
[^9]: Janssen, Augustus Josephus Elizabeth Maria, J. S. H. Van Leeuwaarden, and Bert Zwart. "Gaussian expansions and bounds for the Poisson distribution applied to the Erlang B formula." Advances in Applied Probability 40.1 (2008): 122-143.([link](https://www.cambridge.org/core/journals/advances-in-applied-probability/article/gaussian-expansions-and-bounds-for-the-poisson-distribution-applied-to-the-erlang-b-formula/76DB4F08E5A5DE90D85A90E9D0788DA7#))
[^10]: [Wikipedia: Normal distribution](https://en.wikipedia.org/wiki/Normal_distribution).
