---
layout: post
title: "Blog power: Neil Gunther"
date: 2018-02-19 08:00:00 -0400
author: Victor E. Bazterra
categories: guerrilla-capacity-planning
javascript:
  katex: true
---

How many times you hear people saying with very authoritative voice that **past history is not a good predictor of the future**. Well, although it is likely to be true that past performance does not predict future returns for certain financial instruments, this is not true for large number of systems. So, I would be careful to discard the emergence of momentum in the behavior of event for relatively complex systems.

For systems I will be referring most of the time one or many computers usually working within a data center. However, most of what is discussed in this post can be applied potentially to other interactive systems.

This and many other lessons of avoiding over complicated system analysis when sizing system capacity is one of the main lessons I learned from Neil Gunther[^1]. In particular, relative short planning scenarios of several months implies low precision but cost effective methods are likely to be the best solution. Moreover, relatively simply models are easier to communicate and more likely to convince less experience stakeholders that your system projections are sound. Neil calls this approach **Guerrilla Capacity Planning** due to the fact he uses it for sizing future capacity for IT systems.

However, although I have to admit I am always a bit suspicious of Neil approaches and demonstrations, I have been inspired by them many times. It is also true, that in practice I found them simple to implement and with enough predictive power for the task at hand.

In this post I will show how using simple regression of a past system indicator can be used to predict its future values. I will be following chapter ? from Neil's Guerrilla Capacity Planning book[^2]. As example, I will try to predict the future world population size. In particular, I am interested on which year the world population would be of 15 billion people that is roughly twice as it was 2016 (NOTE: GUNTHER NAME FOR THIS).

The this projection to work we need to assume that population size presents momentum in the sense its future behavior can be extrapolated using a polynomial (a quadratic polynomial in this particular case). The polynomial parameters are extracted from fitting the population size from 1960 to 2016[^3]. The projection is then used to locate the year in where population size intersect the arbitrary ceiling of 15 billion people.

My main enhancement to Neil's idea is to add estimation of confidence interval

Hola[^1] chau[^2] bye[^3].

![Simple world population projection]({{ "/assets/images/world-population-projection.svg" | absolute_url }})

#### References

[^1]: [The Pith of Performance](http://perfdynamics.blogspot.com/).

[^2]: [Gunther, Neil J., Guerrilla Capacity Planning](http://www.springer.com/us/book/9783540261384)

[^3]: [The world bank data: Population, total](https://data.worldbank.org/indicator/SP.POP.TOTL)

[^3]: [Future Population Growth](https://ourworldindata.org/future-population-growth/)
