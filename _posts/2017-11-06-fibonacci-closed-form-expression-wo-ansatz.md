---
layout: post
title: Fibonacci closed-form expression without ansatz
date: 2017-11-06 14:00:00 -0400
author: Victor E. Bazterra
categories: computer-science math
javascript:
  katex: true
---

In a [previous blog]({% post_url 2017-10-30-fibonacci-closed-form-expression %}), I showed
how using an ansatz we can verify the closed-form expression of the Fibonacci sequence. In this blog, I will show how to derive this expression without the support of an ansatz. Although there are several alternatives for doing this (such as using linear algebra[^1]), in this post I will use *generating function approach* following an exercise extracted from my favorite book about algorithms[^2].

The *generating function* for Fibonacci sequence is defined by the following infinite series

<p>%%
F(z) = \sum_{n \geq 0} f_n z^n
%%</p>

where \\|f_n\\| if the n-th Fibonacci number. Let's assume that there is a \\|R > 0\\| in which the series is absolutely convergent for \\|\vert z \vert<R\\|, in where \\|R\\| is convergence ratio. The analytical function defined by \\|F(z)\\| codifies the whole Fibonacci sequence in the values of its derivatives for \\|z = 0\\| or

<p>%%
f_n = \frac{d^nF}{dz^n}\bigg\vert_{z=0}
%%</p>

Now it is true for \\|F(z)\\| the following expression

<p>%%
\begin{aligned}
F(z) = z + z F(z) + z^2 F(z) \Leftrightarrow F(z) = \frac{z}{1 - z - z^2}.
\end{aligned}
%%</p>

Here it is the proof of the previous expression

<p>%%
\begin{aligned}
    F(z) &= z + \sum_{n \geq 2} f_n z^n \\
         &= z + z^2 \sum_{n \geq 0} f_{n+2} z^n \\
         &= z + z^2 \sum_{n \geq 0} (f_{n+1} + f_n) z^n \\
         &= z + z^2 \sum_{n \geq 1} f_n z^{n-1} + z^2 F(z) \\
         &= z + z F(z) + z^2 F(z)
\end{aligned}
%%</p>

in where in the last steps I use the recurrence expression of the Fibonacci sequence and the fact the initial conditions are \\|f_0 = 0\\| and \\|f_1 = 1\\|.

Implicitly, I have assumed that all intermediary series are absolutely convergent! For example, it is important to realize that should at least \\|\vert z \vert < 1\\|, because \\|F(1)\\| is the infinite sum of the whole Fibonacci sequence and therefore it diverges. However, previous expression gives that \\|F(1) = 1/(1-1-1^2) = -1\\|. Infinities series are magical, **but they are not inconsistently magical**!

Using the expression of generating function and the fact that polynomial in the denominator can be factorized \\|1 - z - z^2 = -(\mu - z)(\nu - z)\\| where \\|\mu\\| and \\|\nu\\| are its roots, then

<p>%%
\begin{aligned}
    F(z) &= \frac{z}{1 - z - z^2} \\
         &= \frac{z}{-(\mu - z)(\nu - z)} \\
         &= \frac{z}{-\mu\nu(1 - z\mu^{-1})(1 - z\nu^{-1})} \\
         &= \frac{z}{(1 - z\varphi)(1 - z\psi)}     
\end{aligned}
%%</p>

where \\|\varphi\\| and \\|\psi\\| are the reciprocal of the roots of the polynomial in the denominator or

<p>%%
\varphi^{-1} = \mu = \frac{-1 + \sqrt5}{2} \text{  and  } \psi^{-1} = \nu = \frac{-1 - \sqrt5}{2}
%%</p>

and moreover \\|\mu \nu = -1\\|. Now, by doing partial fraction decomposition[^3] we can obtain

<p>%%
\begin{aligned}
F(z) &= \frac{z}{(1 - z\varphi)(1 - z\psi)} \\
     &= \frac{1}{\sqrt5}\left(\frac{1}{1 - z\varphi} - \frac{1}{1 - z\psi}\right) \\
     &= \sum_{n\geq0} \frac{\varphi^n - \psi^n}{\sqrt5} z^n
\end{aligned}
%%</p>

in where the last points we use the fact that \\|\varphi - \psi = \sqrt{5}\\| and geometric series result

<p>%%
\frac{1}{1-x} = \sum_{n \geq 0} x^n
%%</p>

The geometric series converge absolutely if \\| \vert x \vert < 1 \\|, that in this case implies \\| \vert z \vert < 1/\varphi = -\psi \\| and therefore, the radius of convergence is \\| R = -\psi\\|.

The last expression for \\|F(z)\\| implies then that each term of the Fibonacci sequence is given by

<p>%%
f_n = \frac{\varphi^n - \psi^n}{\sqrt5}.
%%</p>

This was done by analyzing and rewriting the generating function of the sequence without using an ansatz.

The main takeaway of this exercise is that you can use properties of an analytical function to derive facts about a discrete sequence of integers. In this particular case, this approach was used to find an efficiently way for computing the Fibonacci sequence!

#### References

[^1]: [Fibonacci numbers in matrix form](https://en.wikipedia.org/wiki/Fibonacci_number#Matrix_form).

[^2]: [Introduction to algorithms, 3rd edition, problem 4.4](https://mitpress.mit.edu/books/introduction-algorithms).

[^3]: [Partial fraction decomposition](https://en.wikipedia.org/wiki/Partial_fraction_decomposition)
