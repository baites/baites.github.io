---
layout: post
title: Fibonacci recursive and iterative algorithms
date: 2017-10-23 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms computer-science
javascript:
  katex: true
---

This started as a simple coding exercise to illustrate to some of my coworkers one of my early intuition about recursive and iterative algorithms.

Roughly speaking, I will be calling a *recursive algorithm* to any algorithm that solves a particular problem by calling directly or indirectly to itself. Each of these call inputs are a smaller or modify version of the initial problem instance. Alternative, a *iterative algorithm* is an algorithm that solves instances of a given problem by a series of steps or iterations. The expectation is that after a number of those steps the algorithm can output the right solution.

Since my teens I had a conjecture, let's call it following an arbitrary order **Bazterra conjecture #1**[^1].

> **Bazterra conjecture #1:** for any recursive(iterative) algorithm there is a iterative(recursive) reciprocal algorithm that can solve the same problem. Even more, both the original and reciprocal algorithms belong to the same complexity class.

This is by no means anything new and it currently a well understood concept. There are moreover heuristics rules of when using a recursive or iterative algorithm based on the problem instance sizes and language characteristics used in the implementation[^2]. As example of this point, you find a simple [recursive](https://github.com/baites/examples/blob/master/algorithms/javascript/RecursiveFibonacci.js) and [iterative](https://github.com/baites/examples/blob/master/algorithms/javascript/IterativeFibonacci.js) versions written in javascript of the *Fibonacci* series in my [example github repo](https://github.com/baites/examples). The Fibonacci series is a sequence of numbers defined by the following linear recurrence relation

<p>%%
f_n = f_{n-1} + f_{n-2} \text{   for any   } n > 1
%%</p>

with initial values \\|f_0 = 0\\| and \\|f_1 = 1\\|.

Eventually, I found out that I was not very original when choosing this series to illustrate this point[^3]. Even more, in the same reference the recursive implementation of the Fibonacci was example of *excessive recursion*. Also, I gather from multiple sources a third way of implementing the series using a [*closed-form* expression or *formula* for the Fibonacci series](https://github.com/baites/examples/blob/master/algorithms/javascript/CloseFormFibonacci.js)[^4]. This is basically:

<p>%%
f_n = \left[\frac{\varphi^n}{\sqrt{5}}\right]
%%</p>

where \\|\varphi = \frac{1}{2}\left(1+\sqrt{5}\right)\\|, and \\|[\cdot]\\| denote rounding to the closes integer.

Because I am not formally train in algorithms, I though to myself *how in the world can this be the Fibonacci series?*. Where is the magic that connects Fibonacci recurrence with this formula? Moreover, if you are looking for some more mysticism, the constant \\|\varphi\\| is the famous golden ration[^5].

In my **next post**, I will show that this formula indeed defines the Fibonacci series.

[^1]: This is one of my recurrent jokes after another Argentinian-American physics know for such *"simple conjecture"* such as [AdS/CFT correspondence](https://en.wikipedia.org/wiki/AdS/CFT_correspondence) or more recently [ER=EPR](https://en.wikipedia.org/wiki/ER%3DEPR).

[^2]: [Recursion (computer science)](https://en.wikipedia.org/wiki/Recursion_(computer_science)).

[^3]: [Adam Drozdek, Data Structures and Algorithms in C++, chap 5.](https://www.amazon.com/Data-Structures-Algorithms-Adam-Drozdek/dp/1133608426).

[^4]: Including some people completing because they were asked about it in job interviews!

[^5]: [Golden ratio](https://en.wikipedia.org/wiki/Golden_ratio)
