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

Around the time I was researching the theme of the third blog, it was easy to see that procedure used to derive the close form of the Fibonacci series would work also for ANY linear recurrence sequence. I thought it would be neat and original idea to try to derive it and I started working on my own. But first, what do I mean for a linear recurrence sequence?

> **Definition**: a M-linear recurrence sequence is a sequence of numbers given by the following function

<p>%%
f_n = \begin{cases}
b_n & 0 \leq n < M \\
\sum^{M}_{m=1} a_m f_{n-m} & n \geq M
\end{cases}
%%</p>

> in where \\|\{b_n\}\\| are initial sequence values (initial conditions) and for \\|n \geq M\\| the values of \\|f_n\\| is given by a linear combination of the previous values of the with coefficients \\|\{a_m\}\\|.

Looking for reference to support my generalization, I found a lot more references and eventually I realized the subject was, to put it mildly, **very well understood**.

The approach I prefer uses the generating function of the sequence and it is superbly expose in the book *Concrete Mathematics*[^1]. As it is in the case of the Fibonacci series, there is an alternative approach using linear algebra. The most general result requires the use of *Jordan decomposition* of the recurrence matrix[^2].

So the question is, what do I have to offer in this and coming posts? Well, most of the results derive a general expression for the close form that it is used as an ansatz. Any remaining unknowns constants are derived by forcing the initial conditions. My goal in here is to code *a direct construction of the generating function* for any linear recurrence sequence. The program will take as input the \\|a_m\\| and \\|b_n\\| coefficients and it will provide its close-form expression[^3].

> **Proposition**: the generating function of M-linear recurrence sequence is a rational function

<p>%%
F(z) = \frac{P(z)}{Q(z)}
%%</p>

> in where the order of the polynomials \\|P(z)\\| and \\|Q(z)\\| are \\|M-1\\| and \\|M\\| respectively, and their coefficients are given by

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

Proving this proposition is not that hard, however it takes some time to find the right notation for it. Below is my version of this proof taking several intermediate steps to help its derivation.

<p>%%
\begin{aligned}
    F(z) &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1}\sum_{n\geq M} a_m f_{n-m} z^n\\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m \sum_{n\geq M-m} f_n z^n \\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M-1}_{m=1} a_m z^m \left(F(z)  - \sum^{M-m-1}_{n = 0} b_n z^n \right) + a_M z^M F(z) \\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m F(z) - \sum^{M-1}_{m=1} \sum^{M-m-1}_{n = 0} a_m b_n z^{n+m} \\
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{m=1} \sum^{M-1}_{n = m} a_m b_{n-m} z^n \\
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{n=1} \sum^{n}_{m = 1} a_m b_{n-m} z^n \\
    Q(z)F(z) &= P(z)
\end{aligned}
%%</p>

If you are unsure of the previous steps do not worry. In the next post, I will use this proposition to write the first version of the program capable of computing the close form of a large family of linear recurrence sequence. In this way you will be able to check the veracity of proposition by directly looking at the result of the program.

[^1]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).

[^2]: [Sucessiones recursivas lineales](http://cms.dm.uba.ar/depto/public/notas/notas/N2.pdf). As far I know, this is only one reference that derived the general result with linear algebra. I found it by accidentally checking, for different reasons, the website of the Department of Mathematics at Buenos Aires University (my Alma mater). So fresh up your Spanish or just read between the line because it is **really good**.

[^3]: As far I know, there is not reference that treat the subject in this way. However, this is not really that hard so please do not expect too much from an simple exercise.
