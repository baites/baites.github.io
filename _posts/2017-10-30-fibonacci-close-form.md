---
layout: post
title: Fibonacci close form
date: 2017-10-30 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science algorithms math
javascript:
  katex: true
---

In a [previous blog]({% post_url 2017-10-23-fibonacci-recursive-and-iterative-algorithms %}) I discussed different ways of implementing Fibonacci series, finishing with the simple and mind blowing close form.

In this blog, I will show that the proposed close form really generate the Fibonacci series using the following ansatz[^1]:

<p>%%
f_n \propto \varphi^n - \psi^n
%%</p>

where \\|\varphi\\| and \\|\psi\\| are to unknown constants. Now, if we replace the ansatz in to the Fibonacci recurrence relation we get as result

<p>%%
f_n \propto f_{n-1} + f_{n-2} \propto \varphi^n (\varphi^{-1} + \varphi^{-2}) - \psi^n (\psi^{-1} + \psi^{-2})
%%</p>

and therefore the only way to comply with the recurrence formula is if

<p>%%
\varphi^{-1} + \varphi^{-2} = \psi^{-1} + \psi^{-2} = 1.
%%</p>

Following this through we can see that

<p>%%
\varphi^{-1} + \varphi^{-2} = \frac{\varphi + 1}{\varphi^{2}} = 1 \Leftrightarrow \varphi^{2} - \varphi - 1 = 0
%%</p>

where this is also true for \\|\psi\\|, and therefore both constants are the roots of a polynomial, meaning they are the solution of

<p>%%
x^2 - x - 1 = 0
%%</p>

or

<p>%%
\varphi = \frac{1}{2}\left(1+\sqrt{5}\right) \text{    } \psi = \frac{1}{2}\left(1-\sqrt{5}\right).
%%</p>


[^1]: This is by no means new, see for example the [wikipedia entry](https://en.wikipedia.org/wiki/Fibonacci_number). However, the particular form I choose to prove was written by me without using external references.
