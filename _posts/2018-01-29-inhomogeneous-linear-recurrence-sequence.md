---
layout: post
title: Inhomogeneous linear recurrence sequences
date: 2018-01-29 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math
javascript:
  katex: true
  pseudocode: true
---

This is the last of a series of posts in where I discuss how to compute close-from expression for any linear recurrence sequences, see below.

* [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})
* [Linear recurrence sequences with distinct poles]({% post_url 2018-01-15-linear-recurrence-sequences-with-distinct-poles %})
* [Close-form for any linear recurrence sequences?]({% post_url 2018-01-22-close-form-for-any-linear-recurrence-sequence %})

In the previous post, I found that the procedure does not work for sequence with inhomogeneous linear recurrences. So lets start first defining what are these kind of sequences.

> **Definition**: a M-inhomogeneous linear recurrence sequence is a sequence of numbers given by the following function

<p>%%
f_n = \begin{cases}
b_n & 0 \leq n < M \\
\sum^{M}_{m=1} a_m f_{n-m} + g_{n-M} & n \geq M
\end{cases}
%%</p>

> in where \\|b_n\\| are initial sequence values (initial conditions), and for \\|n \geq M\\| the value of \\|f_n\\| is given by a linear combination of the previous values of the with coefficients \\|a_m\\| and inhomogeneous terms given by the sequence \\|g_n\\|.

The challenge now is that embedded in the recurrence, there is a whole new sequence \\|g_n\\| that somewhat break any regularity brought by the linear recurrence. So, we need some assumption about \\|g_n\\| to make possible to derive a close-form expression. Let's \\|G(z)\\| the generating function of the sequence \\|g_n\\| and, lets assume it can be expressed as a rational function \\|G(z)=P_I(z)/G_I(z)\\| where \\|P_I(z)\\| and \\|G_I(z)\\| are any two polynomials (suffix *I* is because they related to inhomogeneous series).

It is not hard to prove following similar steps as one one shown in a previous post[^1] that the generating function \\|F(z)\\| for sequence \\|f_n\\| can be written then as

<p>%%
\begin{aligned}
Q_O(z)F(z) &= P_O(z) + z^M G(z) \\
Q_O(z)F(z) &= P_O(z) + z^M \frac{P_I(z)}{Q_I(x)} \\
      F(z) &= \frac{P_O(z)Q_I(z) + z^M P_I(z)}{Q_O(z)Q_I(z)} \\
           &= \frac{P(z)}{Q(z)}
\end{aligned}
%%</p>

in where \\|P_O(z)\\| and \\|Q_O(z)\\| are polynomials that form a rational generating function for homogeneous \\|f_n\\| sequence, e.i. the sequence resulting of linear recurrence for case \\|g_n = 0\\| as defined also previous sections.

In summary, we define *sufficient condition* so the *inhomogeneous sequence* has a *rational function* as its generator. Therefore, we can now used what was developed in the previous blog to derive a close form[^2].

There is however one caveat. The polynomial order or degree for \\|\text{deg}(P)\\| and \\|\text{deg}(Q)\\| depend on \\|G(z)\\|, and  it could be not true that \\|\text{deg}(P) < \text{deg}(Q)\\| as it was always the case homogeneous recurrence sequences. As result the *partial fraction decomposition*
of the generating function for the whole sequence could contain a residual polynomial with coefficients \\|h_i\\| resulting in

<p>%%
F(z) = \sum^{D}_{i=1} \sum^{m_i}_{k=1} \frac{r_{ik}}{(z-\eta_i)^k} + \mathbf{1} _{\{\Delta_{\deg} \geq 0\}} \sum^{\Delta_{\deg}}_{i=0} h_i z^i
%%</p>

where \\|\Delta_{\text{deg}} = \text{deg}(P) - \text{deg}(Q)\\|, and \\| \mathbf{1}\\| is the indicator function[^2]. The resulting expression becomes like the one the previous post for homogeneous sequences because in that case \\|\text{deg}(P) = M-1\\| and \\|\text{deg}(Q) = M\\|[^3]. Using this updated partial decomposition, it is not hard to follow the same steps as previous post resulting in a general close form as

<p>%%
f_n = \sum^{D}_{i=1} c_i(n) \eta^{-n}_i + \mathbf{1} _{\{\Delta_{\deg} \geq 0\}} \sum^{\Delta_{\deg}}_{i=0} h_i \delta_{in}.
%%</p>

in where

<p>%%
c_i(n) = \sum^{m_i}_{k=1} \binom{k+n-1}{n} (-\eta_i)^{-k} r_{ik}
%%</p>

The pseudocode to compute the close form is shown below.

{% include pseudocode id="CloseFormV2" code="
\begin{algorithm}
\caption{CloseFormV2}
\begin{algorithmic}
\FUNCTION{CreateF}{$a,b,p_I,q_I$}
    \STATE $q_O$ = \CALL{CreateQ}{$a$}
    \STATE $p_O$ = \CALL{CreateP}{$a,b$}
    \STATE $M = \text{len}(a)$
    \STATE $P = P_O Q_I + z^M P_I$
    \STATE $Q = Q_O Q_I$    
    \RETURN $P,Q$
\ENDFUNCTION
\FUNCTION{CloseFormV2}{$a,b,p_I,q_I$}
    \STATE $P,Q$ = \CALL{CreateF}{$a,b,p_I,q_I$}
    \STATE compute partial fraction decomposition $(P,Q) \rightarrow (r, \eta, h)$
    \RETURN $r, \eta, h$
\ENDFUNCTION
\FUNCTION{EvalCloseFormV2}{$r, \eta, h, n$}
    \STATE Assert len($r$) == len($\eta$)
    \STATE f = 0
    \STATE k = 0
    \STATE $\eta_{\text{old}} = 0$
    \FOR{$i = 0$ \TO len($r$)}
        \IF{$n$ == $0$ or $\eta_i$ != $\eta_{\text{old}}$}
            \STATE $k = 1$
        \ELSE
            \STATE $k = k + 1$
        \ENDIF
        \STATE $f = f + (-1)^k \binom{k+n-1}{n} r_i \eta_i^{-(n+k)}$
        \IF{$i$ == $n$ and $n$ < $\text{len}(h)$}        
            \STATE $f = f + h_i$
        \ENDIF
        \STATE $\eta_{\text{old}} = \eta_i$
    \ENDFOR
    \RETURN $f$
\ENDFUNCTION
\end{algorithmic}
\end{algorithm}
" %}

This pseudocode can be implemented in any high level language, here are two examples using [matlab](https://github.com/baites/examples/blob/master/algorithms/matlab/GeneralLinearRecurrenceCloseForm.m) and [python](https://github.com/baites/examples/blob/master/algorithms/python/GeneralLinearRecurrenceCloseForm.py).

Let me give you now a numerical example using the sequence example of previous blog ([A006904](https://oeis.org/A006904))[^4]:

<p>%%
f_n = \begin{cases}
1 & n = 0 \text{ and } n = 1 \\
f_{n-1} + f_{n-2} + (-1)^n & n > 1
\end{cases}
%%</p>

This sequence has as recursive coefficients \\|a = (1,2)\\| and initial conditions \\|b = (1,1)\\|. Moreover, it has a inhomogeneous sequence given by \\|g_n = (-1)^n\\| for \\|n > 1\\| with a generating function \\|G(z) = \sum_{n\geq0} (-1)^{n} z^n = (1+z)^{-1}\\|. Therefore, \\|G(z)\\| is rational function with polynomials \\|P_I(z) = 1\\| and \\|Q_I(z) = 1 + x\\|. As result, the generating function for \\|f_n\\| given by the procedure I am describing is:

<p>%%
F(z) = \frac{1 + z + z^2}{1 - 3 z^2 - 2 z^3}.
%%</p>

The \\|F(z)\\| has poles two poles \\|\eta_1 = -1, \eta_2 = 1/2\\| in where \\|-1\\| has multiplicity of \\|2\\| or \\|m_1 = 2, m_2 = 1\\|. The residuals are \\|r_{1,1} = -1/9, r_{1,2} = 1/3, r_{2,1} = -7/18\\|. The residual polynomial is zero or \\|h_i = 0\\|. I extracted all these numbers after running the algorithm and converting them to their closest fraction representation. Moreover, using the fact that \\|\binom{n}{n} = 1\\| and \\|\binom{n+1}{n} = n+1\\|, then the close form for this sequence is

<p>%%
\begin{aligned}
f_n =& [(-\eta_1)^{-1} r_{1,1} + (n+1)(-\eta_1)^{-2} r_{1,2}] \eta_1^{-n} + (-\eta_2)^{-1} r_{2,1} \eta_2^{-n} \\
    =& (-1/9 + n/3 + 1/3)(-1)^n + (7/9) 2^n \\
    =& 1/9[(2 + 3n)(-1)^n + (7)2^n].
\end{aligned}
%%</p>

With this I just reproduced similar result derived for this sequence in Concrete Mathematics[^4]. The main advantage is that we are testing numerical approach that allow us to explore any other inhomogeneous linear recurrence sequence consistent with the blog assumptions.

#### Conclusion ####

After researching for sometime the close-form expressions, I found that my initial surprise of their existence was superficial. In many ways, linear recursive expressions looks like as a linear system of ordinary differential equations[^5]. You could even think recursive expression as linear system difference equations[^6]. Therefore the existence of a close form is equivalent of having analytical solution resulting of **integrating** these equations. As someone originally trained in Physics this is not surprising at all. However, because of the emphasis in physics is on studying continuum systems, I was not able initially to see the similarities between linear system of **differential** and **difference** equations!

#### Reference ####

[^1]: [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})
[^2]: [Indicator function](https://en.wikipedia.org/wiki/Indicator_function)
[^3]: [Close-form for any linear recurrence sequences?]({% post_url 2018-01-22-close-form-for-any-linear-recurrence-sequence %})
[^4]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition, page 341)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).
[^5]: [Linear differential equations](https://en.wikipedia.org/wiki/Linear_differential_equation), [Ordinary differential equations](https://en.wikipedia.org/wiki/Ordinary_differential_equation)
[^6]: [Linear difference equation](https://en.wikipedia.org/wiki/Linear_difference_equation)
