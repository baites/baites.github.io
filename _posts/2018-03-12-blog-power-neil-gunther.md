---
layout: post
title: "Blog power: Neil Gunther"
date: 2018-03-12 08:00:00 -0400
author: Victor E. Bazterra
categories: guerrilla-capacity-planning
---

How many times you hear people saying with very authoritative voice that **past history is not a good predictor of the future events**. Well, although it is likely to be true that past performance does not predict future returns for certain financial instruments, still could be true for large number of systems. So, I would be very careful in discarding the emergence of momentum in the dynamics of complex systems.

I am usually interested on system made of one or many computers, typically  working within a data center. However, most of what I will be discussed in this post, can be applied potentially to other type of systems. As an exercise, I will try to project the size of future world population.

Avoiding over-complicated analysis when sizing a system capacity is one of the main lessons I learned from Neil Gunther[^1]. It is possible that it is more cost effective to use simpler but approximated models when predicting system growth for relative short-term planning scenarios. Moreover, this type of models are easier to communicate and more likely to sound convincing to lesser experience stakeholders. Neil calls this approach **Guerrilla Capacity Planning**, due to the fact he uses it for sizing future capacity for IT systems.

In this post, I will show how using a simple linear regression of a past system indicator can be used to predict its future value. This approach was inspired by Neil's Guerrilla Capacity Planning book[^2] and paper[^3]. Specifically, I am interested to know on which year the world population would be of 15 billion people, that is roughly twice as it was 2016, or the *doubling period* as defined by Neil.

For this projection to work, we need to assume that population size presents some momentum, in the sense its future behavior can be extrapolated using a polynomial function (I am choosing a quadratic polynomial in this particular case). I extracted the polynomial parameters by fitting the population size from 1960 to 2016[^4]. This is shown in the first graph in the plot below. The projection is then used to find the year by which population size intersect at 15 billion. The extrapolation is shown in the second graph of the plot below. One enhancement I added relative to original proposal, it is the use of confidence intervals and their projection, to set lower and upper bounds for the doubling period. The resulting period can be interpreted as the uncertainty associated to the extrapolation.

![Simple world population projection]({{ "/assets/images/world-population-projection.svg" | absolute_url }})

This projection suggests world population size will reach about 15 billion people in the year 2092 with a error range between 2089 and 2095.

This procedure, although very approximated, it is in general easy to do! See my implementation using MATLAB[^5]. This is the reason it is customary to iterate and produce periodic updates of the projected doubling period of your variable of interest. If you are projecting the value of some limited resource in your system (like total aggregated storage capacity for example), you could use this to estimate how fast yo need to procure more resources. This procedure can also be used to detect unexpected *out of trend changes* in how resources are consumed. This is possible when projected values change significantly between iterations.

Now, how well did this projection work for a world population? Well, we can compare it with more sophisticated ones that uses more detailed information from trends in fertility rates, life expectancy, etc[^6]. In particular, the **UN High Variant** projection suggest that population will reach 15 billion people by 2088 compatible with the result from the naive extrapolation. However, the **UN Medium Variant** predict a population of about ~11 billion by the year 2088 when controlling for more details[^6]. This means that the UN expects a reduction of growth rate relatively past trends.

So here you have it, a simple trick that should never be underestimated! Thanks to Neil for showing me the need for practical approaches for system analysis!

#### References

[^1]: [The Pith of Performance](http://perfdynamics.blogspot.com/).

[^2]: [Gunther, Neil J., Guerrilla Capacity Planning, chapter 8](http://www.springer.com/us/book/9783540261384)

[^3]: [Gunther, Neil J., Performance and Scalability Models for a Hypergrowth e-Commerce Web Site](https://arxiv.org/pdf/cs/0012022.pdf)

[^4]: [The world bank data: Population, total](https://data.worldbank.org/indicator/SP.POP.TOTL)

[^5]: [MATLAB script for world population projection](https://github.com/baites/examples/blob/master/analyses/matlab/population_projection.m)

[^6]: Max Roser (2017) – Future Population Growth. [Published online at OurWorldInData.org](https://ourworldindata.org/future-population-growth/).
