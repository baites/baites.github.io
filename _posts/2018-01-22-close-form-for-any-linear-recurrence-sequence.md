---
layout: post
title: Close-form for any linear recurrence sequences?
date: 2018-01-22 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithm-analysis computer-science math
javascript:
  katex: true
  pseudocode: true
---

In previous posts, I discussed what is a linear recurrence sequence, and how to compute close-form expression to generate them in the case their generating functions have distinct poles:

* [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})
* [Linear recurrence sequences with distinct poles]({% post_url 2018-01-15-linear-recurrence-sequences-with-distinct-poles %})

In this blog, I will show how to extend these results to include also the case of linear recurrence sequences with and without distinct poles.

In the first blog, I showed that the generating function for *M*-linear recurrence sequence is given by a rational function or \\|F(z) = P(z)/Q(z) \\| for \\|P(z)\\| and \\|Q(z)\\| two polynomials of order \\|M-1\\| and \\|M\\|, respectively. In this case *partial fraction decomposition or expansion* of sequence generator function \\|F(z)\\| as following[^1]:

<p>%%
F(z) = \sum^{D}_{i=1} \sum^{m_i}_{k=0} \frac{r_{ik}}{(z-\eta_i)^k}
%%</p>

where \\|\eta_i\\| and \\|m_i\\| are values and multiplicity of i-th pole, \\|c_{ik}\\| is the residue value of i-th pole in where \\|k\\| is an index that run over all the i-th pole multiplicities, and \\|D\\| is the number of distinct poles so that \\|\sum^{D}_{i=1} m_i = M\\|.

We can follow the same steps as previous post[^2] using the fact that[^3]

<p>%%
(1-x)^{-k} = \sum_{n \geq 0} \binom{k+n-1}{n} x^n
%%</p>

resulting in close form for any linear recursive sequence as

<p>%%
f_n = \sum^{D}_{i=1} c_i(n) \eta_i^{-n}
%%</p>

in where

<p>%%
c_i(n) = \sum^{m_i}_{k=1} \binom{k+n-1}{n} (-\eta_i)^{-k} r_{ik}
%%</p>

**Exercise:** follow the similar steps in previous post and prove the above result.

A few remarks about this close form compare to the more restricted case in previous blog[^2]. It uses directly the value of the poles \\|\eta_i\\| instead its reciprocal \\|\rho_i\\|. Moreover, the "coefficients" associated to each pole \\|c_i(n)\\| are now actually functions of \\|n\\| in the case pole multiplicity \\|m_i > 1\\|.

Now, you can say ok let get to the coding we are finally done with this. However, I realize at this point (yes, almost at the end) that there are **other very common** linear recurrence sequences that are **NOT covered** by the formulation in this series of posts. For example, take a look to the following sequence ([A006904](https://oeis.org/A006904))[^4]

<p>%%
f_n = \begin{cases}
1 & n = 0 \text{ and } n = 1 \\
g_{n-1} + 2g_{n-2} + (-1)^n & n > 1
\end{cases}
%%</p>

in where this sequence do not follow the definition of linear recurrence sequence given in the initial blog of this series[^5], because of the extra term \\|(-1)^n\\| that make the recurrence inhomogeneous.

Therefore we need to take a break, to learn how to handle these inhomogeneous linear recurrence sequences. I am planning to do so in the next post.

#### References ####

[^1]: [Partial fraction decomposition](https://en.wikipedia.org/wiki/Partial_fraction_decomposition)

[^2]: [Linear recurrence sequences with distinct poles]({% post_url 2018-01-15-linear-recurrence-sequences-with-distinct-poles %})

[^3]: [Multisets](https://en.wikipedia.org/wiki/Multiset)

[^4]: [Concrete Mathematics: A Foundation for Computer Science (2nd Edition)](https://www.amazon.com/Concrete-Mathematics-Foundation-Computer-Science/dp/0201558025).

[^5]: [Linear recurrence sequences]({% post_url 2018-01-08-linear-recurrence-sequences %})
