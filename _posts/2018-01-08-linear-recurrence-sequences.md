---
layout: post
title: Linear recurrence sequences
date: 2018-01-09 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math
javascript:
  katex: true
  pseudocode: true  
---

These notes are the result of how I lost my mind when researching the Fibonacci sequence. I wrote already four posts about it, in where I discussed how to derive a close form to compute the whole sequence, see below.

* [Fibonacci recursive and iterative algorithms]({% post_url 2017-10-23-fibonacci-recursive-and-iterative-algorithms %})
* [Fibonacci closed-form expression]({% post_url 2017-10-30-fibonacci-closed-form-expression %})
* [Fibonacci closed-from expression without ansatz]({% post_url 2017-11-06-fibonacci-closed-form-expression-wo-ansatz %})
* [Fibonacci excessive recursion]({% post_url 2017-11-13-fibonacci-excessive-recursion %})

Around the time I was writing third blog, it was easy to see that procedure I was following to derive the close form would work also for ANY linear recurrence sequence. I thought it would be neat (may be even original) idea to try to create an algorithm to derive the close form for any linear recurrence sequence and I started working on it. But first, let me define what I mean for a linear recurrence sequence.

> **Definition**: a M-linear recurrence sequence is a sequence of numbers given by the following function

<p>%%
f_n = \begin{cases}
b_n & 0 \leq n < M \\
\sum^{M}_{m=1} a_m f_{n-m} & n \geq M
\end{cases}
%%</p>

> in where \\|\{b_n\}\\| are initial sequence values (initial conditions), and for \\|n \geq M\\|, the values of \\|f_n\\| is given by a linear combination of the previous values with coefficients \\|\{a_m\}\\|.

Looking for sources to support my generalization, I found a lot of references and eventually I realized the subject was, to put it mildly, **very well understood**.

In any case, I choose to use generating functions of these sequences as approach to derive their related close forms. This approach is superbly exposed in the book *Concrete Mathematics*[^1]. There is also an alternative method based on linear algebra (as it is also the case for Fibonacci series). Using this method, the most general result requires the use of *Jordan decomposition* of the recurrence matrix[^2].

So the question is, what do I have to offer in this and coming posts? Well, most of the results derive a general expression for the close form that it is used as an ansatz with some unknown constants. Those constant values are obtain by forcing the initial conditions. This procedure is rather simple for some sequences, however it is hard to use it programmatically for any sequence. My goal therefore, it is to code *a direct construction of the close form* for any linear recurrence sequence. The program will take as input the \\|a_m\\| and \\|b_n\\| coefficients and it will provide its close-form expression[^3].

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

Proving this proposition is not that hard, however it takes some time to find the right notation for it. Below is my version of this proof in where I am taking several intermediate steps to help its derivation.

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

If you are unsure of the previous steps do not worry. In the next post, I will use this proposition to write the first version of the program capable of computing the close form for a large family of linear recurrence sequence. In this way, you will be able to check the veracity of proposition by directly looking at the result of the program. In the meantime, I will be given some pseudocode to create the polynomial coefficients for \\|P(z)\\| and \\|Q(z)\\|. This code will be assumed as given in the coming posts.

{% include pseudocode id="CloseForm:CreateP" code="
\begin{algorithm}
\caption{CloseForm:CreateP}
\begin{algorithmic}
\FUNCTION{CreateP}{$a,b$}
    \STATE Assert len($a$) == len($b$)
    \STATE \textit{M} = len($b$)
    \STATE Create array $p$ of dimension M
    \FOR{$n = 0$ \TO M}
        \IF{$n == 0$}
            \STATE $p_n = b_0$
            \STATE continue
        \ENDIF
        \STATE $p_n = b_n$
        \FOR{$m = 1$ \TO $n+1$}
            \STATE $p_n = p_n - a_{m-1} b_{n-m}$
        \ENDFOR
    \ENDFOR
    \RETURN $p$
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
" %}

{% include pseudocode id="CloseForm:CreateQ" code="
\begin{algorithm}
\caption{CloseForm:CreateQ}
\begin{algorithmic}
\FUNCTION{CreateQ}{$a$}
    \STATE \textit{M} = len($a$)
    \STATE Create array $q$ of dimension \textit{M+1}
    \STATE $q_0 = 1$
    \FOR{$n = 0$ \TO \textit{M}}
        \STATE $q_{n+1} = -a_n$
    \ENDFOR
    \RETURN $q$
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
" %}

#### References ####

[^1]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).

[^2]: [Sucessiones recursivas lineales](http://cms.dm.uba.ar/depto/public/notas/notas/N2.pdf). As far I know, this is only reference that derived the general result with linear algebra. I found it by accident when checking the website of the Department of Mathematics at Buenos Aires University (my Alma mater). So fresh up your Spanish or just read between the line because it is **really that good**.

[^3]: As far I know, there is not reference that treat the subject in this way. However, this is not really that hard, so it is likely someone came up with something similar before.
