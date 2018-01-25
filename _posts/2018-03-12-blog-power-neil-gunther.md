---
layout: post
title: "Blog power: Neil Gunther"
date: 2018-03-12 08:00:00 -0400
author: Victor E. Bazterra
categories: guerrilla-capacity-planning
javascript:
  katex: true
---

How many times you hear people saying with very authoritative voice that **past history is not a good predictor of the future**. Well, although it is likely to be true that past performance does not predict future returns for certain financial instruments, this is not true for large number of systems. So, I would be careful in discarding the emergence of momentum in the behavior of complex systems.

For systems I will be referring most of the time one or many computers usually working within a data center. However, most of what is discussed in this post can be applied potentially to other systems. In particular, I will be projecting the world population size as example.

Avoiding over complicated system analysis when sizing system capacity is one of the main lessons I learned from Neil Gunther[^1]. Predicting system growth for relative short term planning scenarios, might imply that low precision but cost effective methods are likely to be the best solution. Moreover, relatively simply models are easier to communicate and more likely to be convincing to lesser experience stakeholders that your system projections are sound. Neil calls this philosophy **Guerrilla Capacity Planning** due to the fact he uses it for sizing future capacity for IT systems.

In this post I will show how using simple regression of a past system indicator can be used to predict its future values. This approach was inspired by Neil's Guerrilla Capacity Planning book[^2] and paper[^3]. As example, I will try to predict the future world population size. In particular, I am interested to know on which year the world population would be of 15 billion people, that is roughly twice as it was 2016 (or the doubling period as defined by Neil).

For this projection to work, we need to assume that population size presents some momentum in the sense its future behavior can be extrapolated using a polynomial (a quadratic polynomial in this particular case). The polynomial parameters are extracted by fitting the population size from 1960 to 2016[^4]. This is shown in the first graph in the plot below. The projection is then used to locate the year in where population size intersect 15 billion people. The extrapolation is shown in the second graph of the plot below. One enhancement I added relative to original proposal is to compute confidence interval and project its lower and upper bound to intercept the ceiling as well. The resulting period range can be interpreted as the uncertainty associated to the extrapolation.

![Simple world population projection]({{ "/assets/images/world-population-projection.svg" | absolute_url }})

Therefore, this projection suggests world population size will reach 15 Billong people in the year 2092 with a error range between 2089 and 2095.

This procedure, although imprecise, it is in general easy to do, see my implementation using MATLAB[^5]. This is the reason it is customary to iterate and produce periodic updates of the projected doubling period of your variable of interest. If you are projecting the value of some limited resource in your system (like total aggregated storage size for example), you could use this procedure to estimate when you are expecting to reach that particular resource ceiling. This procedure can also be used to detect unexpected out of trend changes in your systems when projected values are significantly revised between iterations.

Now how well do this projections works for a world population? Well, we can compare it with more sophisticated ones that uses more detailed information from trends in fertility rates, life expectancy, etc[^6]. In particular, the **UN High Variant** projection suggest that population will reach 15 Billion people by 2088 compatible with the result form the naive extrapolation.

So here you have it, a simple trick that should not be underestimated. Thanks to Neil for showing me the need for simple but practical approaches for analyzing systems.  

#### References

[^1]: [The Pith of Performance](http://perfdynamics.blogspot.com/).

[^2]: [Gunther, Neil J., Guerrilla Capacity Planning, chapter 8](http://www.springer.com/us/book/9783540261384)

[^3]: [Gunther, Neil J., Performance and Scalability Models for a Hypergrowth e-Commerce Web Site](https://arxiv.org/pdf/cs/0012022.pdf)

[^4]: [The world bank data: Population, total](https://data.worldbank.org/indicator/SP.POP.TOTL)

[^5]: [MATLAB script for world population projection](https://github.com/baites/examples/blob/master/analyses/matlab/population_projection.m)

[^6]: Max Roser (2017) – ‘Future Population Growth’. Published online at OurWorldInData.org. Retrieved from: [](https://ourworldindata.org/future-population-growth/ [Online Resource]
