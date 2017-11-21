---
layout: post
title: Fibonacci excessive recursion
date: 2017-11-13 11:20:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science
javascript:
  katex: true
---

This is the last of a series of posts in where I discuss different ways of generating Fibonacci sequence:

* [Fibonacci recursive and iterative algorithms]({% post_url 2017-10-23-fibonacci-recursive-and-iterative-algorithms %})
* [Fibonacci closed-form expression]({% post_url 2017-10-30-fibonacci-closed-form-expression %})
* [Fibonacci closed-from expression without ansatz]({% post_url 2017-11-06-fibonacci-closed-form-expression-wo-ansatz %})

A natural question that arises is then: *which of the different discussed implementations are the best?*

For sure you can say that the **recursive implementation is the worse**. This is because it is easy to prove that to compute \\|f_n\\|, a number of \\|O(f_n)\\| additions (and therefore also function calls) are needed[^1].

From a practical perspective, the recursive algorithm becomes impractical when computing even small instances. The figure below shows execution time that took to run the recursive algorithm to compute \\|{f_n}\\| where \\|n\\| is the *Fibonacci index number*. I implemented the same algorithm in both [C++](https://github.com/baites/examples/blob/master/algorithms/c%2B%2B/IterativeFibonacci.C) and [javascript](https://github.com/baites/examples/blob/master/algorithms/javascript/IterativeFibonacci.js) for comparison. Although *C++* is faster, both algorithms presents what it looks like exponential growth of the execution time as instance size increases[^2].

{% include image file="recursive-fibonacci.svg" scale="60%" %}

The complexity of the iterative algorithm ([C++](https://github.com/baites/examples/blob/master/algorithms/c%2B%2B/IterativeFibonacci.C), [javascript](https://github.com/baites/examples/blob/master/algorithms/javascript/IterativeFibonacci.js)) is only \\|O(n)\\|[^1] and therefore it is efficient in generating Fibonacci sequence. The closed-form can be seen as evaluating a *n*-order polynomial and therefore I would also expect a complexity of \\|O(n)\\|[^3].

The largest number I was able to compute with a double float number in *C++* was \\|f_{1476} = 1.3069892237633987e+308\\| and it took about 5 ms for both iterative and closed-form algorithms. For javascript, nodejs took about 150 ms for both types of algorithms.  

You can argue that the closed-form form is not only efficient but also aesthetically more pleasing. However, there is more than simply beauty in it, because it also allow us to deduce that the Fibonacci series growth exponentially

<p>%%
\lim_{n \rightarrow \infty} \frac{\sqrt{5}f_n}{\varphi^n} = 1,
%%</p>

and therefore, it can be proved that recursive implementation of Fibonacci sequence has **exponential complexity** or \\|O(\varphi^n)\\|.

#### References

[^1]: [Adam Drozdek, Data Structures and Algorithms in C++, chap 5.](https://www.amazon.com/Data-Structures-Algorithms-Adam-Drozdek/dp/1133608426) \\|O(\cdot)\\| notation represents the asymptotic execution in time (sometimes also in memory space) of an algorithm for large instances. This is commonly referred as the algorithm complexity, see [Big O notation](https://en.wikipedia.org/wiki/Big_O_notation) for more information.

[^2]: Be aware the plot is in logarithmic scale, and therefore a linear growth in that scale is actually an exponential growth!

[^3]: [Computational complexity of mathematical operations.](https://en.wikipedia.org/wiki/Computational_complexity_of_mathematical_operations)
