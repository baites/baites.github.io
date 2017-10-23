---
layout: post
title: Fibonacci recursive and iterative algorithms
date: 2017-10-23 13:20:00 -0400
author: Victor E. Bazterra
categories: algorithms computer-science
javascript:
  katex: true
---

This started as a simple coding exercise to illustrate to some of my coworkers one of my early intuition about recursive and iterative algorithms.

Roughly speaking, I will be calling a *recursive algorithm* to any algorithm that solves a particular problem by calling directly or indirectly to itself. Each call input is a smaller or modify version of the initial problem instance. Alternative, a *iterative algorithm* is an algorithm that solves instances of a problem by a series of steps or iterations. The expectation is that after a number of those steps, the algorithm can output a good approximation or exact solution for each instance.

Since my teens I had a conjecture, that I would call **Bazterra's conjecture #1**[^1] without following any particular order.

> **Bazterra's conjecture #1:** for any recursive(iterative) algorithm there is a iterative(recursive) reciprocal algorithm that can solve the same problem.

This is by no means anything new and it currently a well understood concept. Moreover, there are heuristics rules of when is reasonable to use recursive or iterative algorithm based on the problem instance sizes, and language characteristics used in its implementation[^2].

For example, you find a simple [recursive](https://github.com/baites/examples/blob/master/algorithms/javascript/RecursiveFibonacci.js) and [iterative](https://github.com/baites/examples/blob/master/algorithms/javascript/IterativeFibonacci.js) versions written in javascript to compute the *Fibonacci* series in my [example github repo](https://github.com/baites/examples). The Fibonacci series is a sequence of numbers defined by the following linear recurrence equation

<p>%%
f_n = f_{n-1} + f_{n-2} \text{   for any   } n > 1
%%</p>

with initial values \\|f_0 = 0\\| and \\|f_1 = 1\\|.

Eventually, I found out that I was not very original when choosing this series for comparing recursive and iterative algorithms that can solve the same problem[^3]. Even more, in the reference [3] the recursive implementation of the Fibonacci is an example of *excessive recursion*, more about that this in another blog.

From multiple sources I also learned a third way of implementing the series using a [*closed-form* expression or *formula* for the Fibonacci series](https://github.com/baites/examples/blob/master/algorithms/javascript/CloseFormFibonacci.js)[^4]. This is basically:

<p>%%
f_n = \left[\frac{\varphi^n}{\sqrt{5}}\right]
%%</p>

where \\|\varphi = \frac{1}{2}\left(1+\sqrt{5}\right)\\|, and \\|[\cdot]\\| denote rounding to the closes integer.

Because I am not formally train in algorithms, I though to myself *how in the world can this be the Fibonacci series?*. Where is the magic that connects Fibonacci recurrence with this formula? Moreover, if you are looking for a more numerological or mystical connection, the constant \\|\varphi\\| is the famous golden ration[^5].

In my **next post**, I will try to break this mystical spell by showing that indeed this formula can be used to compute Fibonacci series.

[^1]: This will be one of my recurrent jokes in this blog, inspired by another Argentinian-American physics know to come up with *"simple conjectures"* such as [AdS/CFT correspondence](https://en.wikipedia.org/wiki/AdS/CFT_correspondence) or more recently [ER=EPR](https://en.wikipedia.org/wiki/ER%3DEPR).

[^2]: [Recursion (computer science)](https://en.wikipedia.org/wiki/Recursion_(computer_science)).

[^3]: [Adam Drozdek, Data Structures and Algorithms in C++, chap 5.](https://www.amazon.com/Data-Structures-Algorithms-Adam-Drozdek/dp/1133608426).

[^4]: Including from some people complaining because they were asked about it in job interviews!

[^5]: [Golden ratio](https://en.wikipedia.org/wiki/Golden_ratio)
