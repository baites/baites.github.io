---
layout: post
title: "Fibonacci is back in my life: Huge Fibonacci number modulo m"
date: 2018-03-26 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm algorithm-analysis computer-science fibonacci-series
javascript:
  katex: true
  pseudocode: true
---

| This blog is part of a series dedicated to Fibonacci sequence. [In the Series page you can find the other posts of the series]({{ 'series#fibonacci-series' | relative_url }} ). |

Just when I thought the spell of the Fibonacci series was gone, it came back to my life. I recently started the so far terrific Coursera course *Algorithmic Toolbox* that is part of the *Data structures and algorithms*[^1]. The first advance problem in the second week is as follow.

{% include statement/problem name='Queue length heuristic' %}
Given two integers n and m, output $f_n \text{ mod } m$ (that is, the remainder of $f_n$ when divided by m).
{% include statement/end %}

**Input Format.** The input consists of two integers n and m given on the same line (separated by a space).

**Constraints.** $1 \leq n \leq 10^{18}$, $2 \leq m \leq 10^5$.

**Output Format.** Output  $f_n \text{ mod } m$

{% include statement/remark name='Time limits' %}
language   C  C++  Java  Python  C#   Haskell  JavaScript  Ruby  Scala
time (sec) 1  1    1.5   5       1.5  2        5           5     3
{% include statement/end %}

{% include statement/remark name='Memory limit' %}
512MB.
{% include statement/end %}

It took me some time to go through the problem, and because of it and the fact this was another non-trivial example involving Fibonacci sequence, I decided to blog about it[^2].

I think this problem is meant to show, that sometimes the most efficient algorithms are can only be done if you have some nontrivial insight about the problem. In this case, the problem guide provided as a hint the fact $ f_n \text{ mod } m $ produces a periodic sequence that repeats itself after a number known as Pisano period annotated as $\pi(m)$[^3]. Each repeated cycle always starts with 0, 1 because it is the beginning the first cycle for any $ f_n \text{ mod } m $ with $m > 1$. For example, for the case of m = 2 and 3 the sequences are the ones below:

$f_n \text{ mod } 2 = 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, ... $

$f_n \text{ mod } 3 = 0, 1, 1, 2, 0, 2, 2, 0, 1, 1, ... $

So, if for a given modulo $m$ you know the period $\pi(m)$ of the sequence $f_n \text{ mod } m$ then it follows that

<p>%%
f_n \text{ mod } m = f_{n \text{ mod } \pi(m)} \text{ mod } m
%%</p>

This implies that rather computing "$f_n \text{ mod }m$" you can in principle compute "$f_{n \text{ mod } \pi(m)} \mod m$" that could be significant smaller in complexity[^4]. Therefore, a pseudocode that applies this idea is shown bellow.

{% include pseudocode id="hugefnmodm" lineNumber=true code="
\begin{algorithm}
\caption{Algorithm to compute $f_n \text{ mod } m$ for large $n$}
\begin{algorithmic}
\PROCEDURE{PisanoPeriod}{$m$}
    \STATE previous = 1
    \STATE current = 1
    \FOR{$p = 2$}
        \STATE current = \CALL{FibonacciMod}{$p, m$}
        \IF{previous == 0 \AND current == 1}
          \STATE break
        \ENDIF
        \STATE previous = current
    \ENDFOR
    \STATE p = p - 1
    \RETURN p
\ENDPROCEDURE
\PROCEDURE{HugeFibonacciModulo}{$n,m$}
    \IF{$n < 2$}
        \RETURN n
    \ENDIF
    \STATE $p$ = \CALL{PisanoPeriod}{$m$}
    \RETURN \CALL{FibonacciModulo}{$n \text{ mod } p,m$}
\ENDPROCEDURE
\end{algorithmic}
\end{algorithm}
" %}

I hope you can appreciate the ironically tautological nature of the algorithm, that to compute *HugeFibonacciModulo* you still need to have a somewhat good implementation of *FibonacciModulo*. This implementation is not only required for the return of the function but more importantly when searching for Pisano period.

The naive approach of computing the Fibonacci number and then taking its modulo it is not efficient. This is because you will need to generate huge numbers before making the modulo, increasing the chances of integer overflow. The trick is, therefore, to see if there is a way to apply modulo in intermediate steps when generating the series. For this, we can explore using the modular addition property[^5] resulting in that Fibonacci series module $m$ can be defined by the following recursion

<p>%%
f_n \text{ mod } m = (f_{n-1} \text{ mod } m + f_{n-2} \text{ mod } m) \text{ mod } m \text{   for any   } n > 1
%%</p>

with initial values $f_0 = 0$ and $f_1 = 1$ assuming $m > 1$. The following pseudocode follow implements this recursion.

{% include pseudocode id="fnmodm" lineNumber=true code="
\begin{algorithm}
\caption{Algorithm to compute $f_n \text{ mod } m$}
\begin{algorithmic}
\PROCEDURE{FibonacciModulo}{$n,m$}
    \IF{$n < 2$}
        \RETURN n
    \ENDIF
     \STATE previous = 0
     \STATE current  = 1
     \FOR{$p = 0$ \TO $n - 1$}
         \STATE temp = previous
         \STATE previous = current
         \STATE current = (temp + current) mod $m$
     \ENDFOR
     \RETURN current
\ENDPROCEDURE
\end{algorithmic}
\end{algorithm}
" %}

Combining all these procedures you can write a simple version of this algorithm. I will leave it to the reader to complete this assignment.

Does all this work? Well, sort of. This can compute a huge Fibonacci number module $m$ however, sometimes it might take several seconds to locate the Pisano period when implemented in C++ for some values of $m$. This violates the time requirements of the problem, although the algorithm manages to accomplish the task at the most in a reasonable time (tens of seconds).

The reason for the slow down is that the value of Pisano period can wildly change for each $m$. The figure below shows a uniform random sample of 5000 values of $m$ between $2$ and $ 10^5$ and their corresponding $\pi(m)$. It is easy to observe that $\pi(m)$ tend to be higher as $m$ increases, although there is not a trivial pattern. Therefore, a systematic scanning for a period $\pi(m)$ given value of modulo $m$ has a hard to predict execution time, although on average it gets longer for larger numbers.

{% include image file="pisano-periods.svg" scale="80%" %}

This means there are two alternatives, either you come up with a smarter algorithm to find the Pisano period by exploiting more profound insights from number theory[^6] or, you could use a combination of brute force and a lookup table. Of course, I took the higher ground (aka coward way) and created a lookup table by scanning for the Pisano period for module values $2 \leq m \leq 10^5$. This is only possible thanks to the restricted number of modulo values allowed by the problem statement. The solution I am suggesting might break as soon you allow $m$ to be an order magnitude higher.

Assuming that all Pisano periods are 32-bit integers, we need only 100000 of them or 400KB of memory well within memory constraints. The scanning for all the values Pisano period took around 72 hours running on several ranges for $m$ concurrently in an Intel I7 CPU.

I just give you all the necessary components to create a code with the values of the Pisano periods hard coded. Stress testing my C++ version of this code, I found that it run at most ~1ms well within problem requirements!

# References

[^1]: [Algorithmic toolbox](https://www.coursera.org/learn/algorithmic-toolbox/home/welcome).

[^2]: [It seems I am not the only one, here a link to a blogger also impress by the problem](https://medium.com/competitive/huge-fibonacci-number-modulo-m-6b4926a5c836).

[^3]: [Wiki entry about Pisano period](https://en.wikipedia.org/wiki/Pisano_period), [Wolfram entry about Pisano](http://mathworld.wolfram.com/PisanoPeriod.html)

[^4]: In principle complexity goes from $O(n^2)$ to $O(n \text{ mod } \pi(m))$ in case the value of $m$ can be fixed within 32 bit integer. This is because each iteration sum when computing *FibonacciModulo* algorithm (see later in the post) will be $O(1)$ due to the fact no intermediate number will be larger than $m$.

[^5]: [Khan Academy: Modular addition and subtraction.](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-addition-and-subtraction)

[^6]: [Like the fantastic work from Marc Renault.](http://webspace.ship.edu/msrenault/fibonacci/fib.htm)
