---
layout: post
title: Linear recurrence sequences
date: 2018-01-08 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math
javascript:
  katex: true
---

These notes are the result of how I lost my mind when researching Fibonacci sequence. I wrote already four post about it, in particular in how to derive a close form to compute the whole sequence, see below.

* [Fibonacci recursive and iterative algorithms]({% post_url 2017-10-23-fibonacci-recursive-and-iterative-algorithms %})
* [Fibonacci closed-form expression]({% post_url 2017-10-30-fibonacci-closed-form-expression %})
* [Fibonacci closed-from expression without ansatz]({% post_url 2017-11-06-fibonacci-closed-form-expression-wo-ansatz %})
* [Fibonacci excessive recursion]({% post_url 2017-11-13-fibonacci-excessive-recursion %})

Around the time I was researching the theme of the third blog, it was almost trivial to realize that procedure used to derive the close form would work for ANY linear recurrence sequence. I thought it would be neat and original idea and started to work on my own. But what do I mean for a linear recurrence sequence.

> **Definition**: a M-linear recurrence sequence is a sequence of numbers given by the following function

<p>%%
f_n = \begin{cases}
b_n & 0 \leq n < M \\
\sum^{M}_{m=1} a_m f_{n-m} & n \geq M
\end{cases}
%%</p>

in where \\|\{b_n\}\\| are initial sequence values (initial conditions) and for \\|n \geq M\\| the values of \\|f_n\\| is given by a linear combination of the sequence previous values with coefficients \\|\{a_m\}\\|.

In the process a learn more possible keywords and eventually I found out the subject was, to put it mildly, very well understood.

<p>%%
p_n = \begin{cases}
b_0 & n = 0 \\
b_n - \sum^{n}_{m=1} a_m b_{n-m} & 1 \leq n \leq M - 1
\end{cases}
%%</p>

<p>%%
q_n = \begin{cases}
1 & n = 0 \\
-a_n & 1 \leq n \leq M
\end{cases}
%%</p>
