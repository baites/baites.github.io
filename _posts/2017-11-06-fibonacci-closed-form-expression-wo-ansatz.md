---
layout: post
title: Fibonacci closed-form expression without ansatz
date: 2017-10-30 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science math
javascript:
  katex: true
---

In a [previous blog]({% post_url 2017-10-30-fibonacci-closed-form-expression %}) I showed
how using an ansatz we can verify the closed-form expression of the Fibonacci sequence. What I will try to show in this post is how to derive this expression without the support of the ansatz.

Although there are several alternative for doing this such as using linear algebra[^1], in this post I will use *generating function approach* by following a exercise extracted from my favorite book about algorithms[^2].

The *generating function* for Fibonacci sequence is defined by the following infinite series

<p>%%
F(z) = \sum^{\infty}_{n=0} f_n z^n
%%</p>

where \\|f_n\\| if the n-th Fibonacci number. Let's assume that there is a \\|R > 0\\| in which the series is absolutely convergent for \\|\vert z \vert<R\\|, in where \\|R\\| can be seen as it convergence ratio. The analytical function \\|F(z)\\| codifies the whole Fibonacci sequence in the values of its derivatives for \\|z = 0\\| or

<p>%%
f_n = \frac{d^nF}{dz^n}\bigg\vert_{z=0}
%%</p>

Now it is true \\|F(z)\\| the following expression

<p>%%
F(z) = z + z F(z) + z^2 F(z) \Leftrightarrow F(z) = \frac{z}{1 - z - z^2}
%%</p>

[^1]: [Fibonacci numbers in matrix form](https://en.wikipedia.org/wiki/Fibonacci_number#Matrix_form).

[^2]: [Introduction to algorithms, 3rd edition, problem 4.4](https://mitpress.mit.edu/books/introduction-algorithms).
