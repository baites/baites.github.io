---
layout: post
title: Linear recurrence sequences with distinct poles
date: 2018-01-15 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math
javascript:
  katex: true
  pseudocode: true
---

This is a continuation of a initial post with the end goal of computing a close form for any linear recurrence sequence. Details about what are these sequences and how to compute their generating function are in the first blog:

* [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})

In that blog, I showed that for these sequences, their generating functions are a rational function or

<p>%%
F(z) = \frac{P(z)}{Q(z)}
%%</p>

for \\|P(z)\\| and \\|Q(z)\\| two polynomials of order \\|M-1\\| and \\|M\\|, respectively. Moreover, the coefficients for these polynomials are given by sequence initial condition and the coefficients of the linear recurrence.

Now let's assume that the poles of \\|F(z)\\| are distinct and therefore, it is possible to write the polynomial \\|Q(z)\\| as follow[^1]

<p>%%
Q(z) = q_M \prod^{M}_{i=1} (z-\eta_i)
%%</p>

and therefore there is a *partial fraction decomposition or expansion* of generating function \\|F(z)\\| that can be expressed as bellow[^2]:

<p>%%
\begin{aligned}
F(z) &= \sum^{M}_{i=1} \frac{r_i}{z-\eta_i} \\
     &= \sum^{M}_{i=1} \frac{-\eta_i^{-1}r_i}{(1-z\eta_i^{-1})} \\
     &= \sum^{M}_{i=1} \frac{-\rho_i r_i}{(1-z\rho_i)} \\
     &= \sum^{M}_{i=1} -\rho_i r_i \sum_{n \geq 0} \rho_i^n z^n \\
     &= \sum_{n \geq 0} \sum^{M}_{i=1} c_i \rho_i^n z^n
\end{aligned}
%%</p>

where \\|\rho_i = \eta_i^{-1}\\| or the reciprocal roots of polynomial \\|Q(z)\\|, \\|r_i\\| are the residuals of the partial fraction decomposition, and \\|c_i = -\rho_i r_i\\|. For the last two steps, I used geometric series result:

<p>%%
\sum_{n \geq 0} x^n = \frac{1}{1-x}
%%</p>

and therefore, \\|F(z)\\| domain needs to be defined such as

<p>%%
|z| < \frac{1}{\max_{i}|\rho_i|}
%%</p>

By definition, the associated recursive sequence \\|f_n\\| is then given by the following equation:

<p>%%
f_n = \sum^{M}_{i=1} c_i \rho_i^n
%%</p>

that for the case of distinct poles, there is a close-formed expression for the residues of the decomposition \\|r_i\\|[^1], therefore this is also true for \\|c_i\\| coefficients that can be written as

<p>%%
c_i = \frac{-\rho_i P(\rho_i^{-1})}{Q'(\rho_i^{-1})}
%%</p>

It is important to realize, that the coefficient \\|r_i\\| and reciprocal roots \\|\rho_i\\| are not necessary real numbers. We will see that for most of the example sequences (see program examples), they are actually complex numbers! This will not be an issue if you write the algorithm in a language that support complex as primitive types.

Now, we have all the necessary ingredients to write the algorithm to compute the close form. The algorithm is rather simple and can be easily express as the following pseudocode[^3].

{% include pseudocode id="CloseFormV1" code="
\begin{algorithm}
\caption{CloseFormV1}
\begin{algorithmic}
\FUNCTION{CloseFormV1}{$a,b$}
    \STATE $q$ = \CALL{CreateQ}{$a$}
    \STATE $\hat{q}$ = reverse of $q$
    \STATE $\rho$ = roots of the polynomial $\hat{Q}$
    \STATE $p$ = \CALL{CreateP}{$a,b$}
    \STATE $Q'$ = get the derivative of $Q$
    \FOR{$i = 0$ \TO len($\rho$)}
        \STATE $c_i = -\rho_i P(\rho^{-1}_i)/Q'(\rho^{-1}_i)$
    \ENDFOR
    \RETURN $c$, $\rho$
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
" %}

This code depends of two other functions *CreateP* and *CreateQ* defined in the [previous post]({% post_url 2018-01-08-linear-recurrence-sequences %}). Moreover, the program needs some functions to manipulate polynomials that are easy to find in high level languages. For example, find a full working examples in [MATLAB](https://github.com/baites/examples/blob/master/algorithms/matlab/DistinctPolesLinearRecurrenceCloseForm.m) and [python](https://github.com/baites/examples/blob/master/algorithms/python/DistinctPolesLinearRecurrenceCloseForm.py) of this code.

When I started in working in this project, I dreamed that I could create some kind of generalization to the Fibonacci sequence and put my name to it! I was already naming them the *Bazterra's sequences*.

**Yes, I am that naive some times.**

Anyway, I found that most of the sequence I could think of (the trivial ones) can be found in a wonderful resource know as *The On-Line Encyclopedia of Integer Sequences*[^4]. They provide information about the sequence themselves, and also other data as their generating function and more. I used this database to test the code on several sequences. Within the code comments, I provide the identification code for each sequence within the database, so you can verify the results by yourselves.

#### References ####

[^1]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).

[^2]: [Partial fraction decomposition](https://en.wikipedia.org/wiki/Partial_fraction_decomposition)

[^3]: In this pseudocode I use the convention of expressing polynomial  coefficients as lowercase letters, and with the same letters in uppercase, the actual polynomial functions.

[^4]: [The On-Line Encyclopedia of Integer Sequences](https://oeis.org/).
