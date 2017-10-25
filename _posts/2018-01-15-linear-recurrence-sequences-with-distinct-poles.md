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

This is continuation of a initial post with the end goal of computing a close form for a linear recurrence sequence. Details about what are these sequences and how to compute their generating function are in the first blog:

* [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})

in where I showed that for these sequences, their generating function is given by a rational function or

<p>%%
F(z) = \frac{P(z)}{Q(z)}
%%</p>

for \\|P(z)\\| and \\|Q(z)\\| two polynomials of order \\|M-1\\| and \\|M\\|, respectively. Moreover, I showed how to compute these polynomial coefficients knowing the initial conditions and the coefficients of the linear recurrence.

Now let's assume that the poles of \\|F(z)\\| are distinct and it is possible to write the polynomial \\|Q(z)\\| as follow

<p>%%
Q(z) = q_M \prod^{M}_{i=1} (z-\eta_i)
%%</p>

then it is possible to write *partial fraction decomposition or expansion* of sequence generator function \\|F(z)\\| as following:

<p>%%
\begin{aligned}
F(z) &= \sum^{M}_{i=1} \frac{r_i}{z-\eta_i} \\
     &= \sum^{M}_{i=1} \frac{-\eta_i^{-1}r_i}{(1-z\eta_i^{-1})} \\
     &= \sum^{M}_{i=1} \frac{-\rho_i r_i}{(1-z\rho_i)} \\
     &= \sum^{M}_{i=1} -\rho_i r_i \sum_{n \geq 0} \rho_i^n z^n \\
     &= \sum_{n \geq 0} \sum^{M}_{i=1} c_i \rho_i^n z^n
\end{aligned}
%%</p>

where \\|\rho_i = \eta_i^{-1}\\| or the reciprocal roots of polynomial \\|Q(z)\\|, \\|r_i\\| are the residuals of the partial fraction decomposition, and \\|c_i = -\rho_i r_i\\|. For the last two steps, geometric series result:

<p>%%
\sum_{n \geq 0} x^n = \frac{1}{1-x}
%%</p>

and therefore, \\|F(z)\\| domain needs to be defined such as

<p>%%
|z| < \frac{1}{\max_{i}|\rho_i|}
%%</p>

By definition \\|f_n\\| then is given by

<p>%%
f_n = \sum^{M}_{i=1} c_i \rho_i^n
%%</p>

and for the case of distinct poles there is a close form expression for the residues of the decomposition \\|r_i\\|[^1], so \\|c_i\\| coefficients can be written as

<p>%%
c_i = \frac{-\rho_i P(\rho_i^{-1})}{Q'(\rho_i^{-1})}
%%</p>

{% include pseudocode id="CloseFormV1" code="
\begin{algorithm}
\caption{CloseFormV1}
\begin{algorithmic}
\FUNCTION{CloseFormV1}{$a,b$}
    \STATE $q$ = \CALL{CreateQ}{$a$}
    \STATE $\hat{q}$ = reverse of $q$
    \STATE $\rho$ = roots of the polynomial $\hat{q}$
    \STATE $p$ = \CALL{CreateP}{$a,b$}
    \STATE $q'$ = coefficients of the derivative of $q$
    \FOR{$i = 0$ \TO len($\rho$)}
        \STATE $c_i = -\rho_i$\textit{P}$(\rho^{-1}_i)/$\textit{Q}$'(\rho^{-1}_i)$
    \ENDFOR
    \RETURN $c$, $\rho$
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
" %}

[^1]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025) also  [Partial fraction decomposition entry in wikipedia](https://en.wikipedia.org/wiki/Partial_fraction_decomposition).
