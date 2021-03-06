---
layout: post
title: Linear recurrence sequences
date: 2018-01-09 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math linear-recurrence-series
javascript:
  katex: true
  pseudocode: true
---

| This blog is part of a series dedicated to linear recurrence sequences. [In the Series page you can find all the posts of the series]({{ 'series#linear-recurrence-series' | relative_url }}). |

These notes are the result of how I lost my mind when researching the Fibonacci sequence. [You can find all the posts dedicated to Fibonacci sequence in the Series page.]({{ 'series#fibonacci-series' | relative_url }}).

In those blogs I discussed how to derive a closed form to compute the whole series. Around the time I was writing the third blog, it was easy to see that procedure I was following to derive the closed form would also work for ANY linear recurrence sequence. I thought it would be neat (maybe even original) idea to try to create an algorithm to derive the closed form for any linear recurrence sequence and I started working on it. But first, let me define what I mean for a linear recurrence sequence.

{% include statement/definition %}
a M-linear recurrence sequence is a sequence of numbers given by the following function

$$
f_n = \begin{cases}
b_n & 0 \leq n < M \newline
\sum^{M}_{m=1} a_m f_{n-m} & n \geq M
\end{cases}
$$

in where \\|\{b_n\}\\| are initial sequence values (initial conditions), and for \\|n \geq M\\|, the values of \\|f_n\\| is given by a linear combination of the previous values with coefficients \\|\{a_m\}\\|.
{% include statement/end %}

Looking for sources to support my generalization, I found a lot of references and eventually I realized the subject was, to put it mildly, **very well understood**.

In any case, I choose to use generating functions of these sequences as the approach to derive their related closed forms. I recommend the book *Concrete Mathematics*[^1] where you can find a superbly exposition of this approach. There is also an alternative method based on linear algebra (as it is also the case for Fibonacci series). With this method, the most general result requires the use of *Jordan decomposition* of the recurrence matrix[^2].

So the question is, what do I have to offer in this and coming posts? Well, most of the existing work derive a general expression for the closed form. This form is then used as an ansatz with some unknown constants. You can obtain constant values forcing the initial conditions. This procedure is rather simple for some sequences; however, it is hard to use it programmatically for any sequence. My goal, therefore, it is to code *a direct construction of the closed form expression* to generate any linear recurrence sequence. The program will take as input the \\|a_m\\| and \\|b_n\\| coefficients and it will provide its closed-form expression[^3].

{% include statement/proposition %}
the generating function of M-linear recurrence sequence is a rational function

$$
F(z) = \frac{P(z)}{Q(z)}
$$

in where the order of the polynomials \\|P(z)\\| and \\|Q(z)\\| are \\|M-1\\| and \\|M\\| respectively, and their coefficients are given by

$$
p_n = \begin{cases}
b_0 & n = 0 \newline
b_n - \sum^{n}_{m=1} a_m b_{n-m} & 1 \leq n \leq M - 1
\end{cases}
$$

$$
q_n = \begin{cases}
1 & n = 0 \newline
-a_n & 1 \leq n \leq M
\end{cases}
$$
{% include statement/end %}

Proving this proposition is not that hard; however, it takes some time to find the right notation for it. Below is my version of this proof in where I am making several intermediate steps to help its derivation.

$$
\begin{aligned}
    F(z) &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1}\sum_{n\geq M} a_m f_{n-m} z^n \newline
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m \sum_{n\geq M-m} f_n z^n \newline
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M-1}_{m=1} a_m z^m \left(F(z)  - \sum^{M-m-1}_{n = 0} b_n z^n \right) + a_M z^M F(z) \newline
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m F(z) - \sum^{M-1}_{m=1} \sum^{M-m-1}_{n = 0} a_m b_n z^{n+m} \newline
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{m=1} \sum^{M-1}_{n = m} a_m b_{n-m} z^n \newline
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{n=1} \sum^{n}_{m = 1} a_m b_{n-m} z^n \newline
    Q(z)F(z) &= P(z)
\end{aligned}
$$

If you are unsure of the previous steps, do not worry. In the next post, I will use this proposition to write the first version of the program capable of computing the closed form for a large family of linear recurrence sequence. In this way, you will be able to check the integrity of proposition by directly looking at the result of the program. In the meantime, I will be given some pseudocode to create the polynomial coefficients for \\|P(z)\\| and \\|Q(z)\\|. This code will be assumed as given in the coming posts.

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

# References

[^1]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).

[^2]: [Sucessiones recursivas lineales](http://cms.dm.uba.ar/depto/public/notas/notas/N2.pdf). As far I know, this is the only reference that derived the general result with linear algebra. I found it by accident when checking the website of the Department of Mathematics at Buenos Aires University (my Alma mater). So fresh up your Spanish or just read between the line because it is **really that good**.

[^3]: As far I know, no reference treats the subject in this way. However, this is not that hard, so it is likely someone came up with something similar before.
