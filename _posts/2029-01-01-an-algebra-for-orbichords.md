---
layout: post
title: An algebra for orbichords
date: 2029-01-01 18:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Disclaimer

Disclaimer first because this "algebra" is my own invention. Although the original idea was to apply know results from Abstract Algebra consitently to music, I showed in the previous post ["A pair of pitches with a twist"]({% post_url 2024-10-01-ordered-pair-of-pitches %}) that the formalism of group action cannot represent the simplest case dyads (real pitch dyads). Therefore, this and coming post is my response to fill this gap. It is likely by formulating this "math" I am reiventing the wheel. Be warn!

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## Monoid action and their equivalence group

I explained in the previous post that the main issue we found with group actions was the composition rule base on the group product does not always applied. Therefore, I start defining more generic actions based monoids without proposing any type of composition.

{% include statement/definition name="monoid actions" markdown="block" %}
Let $X$ be a set and a monoid $(G, \cdot, e)$.[^1] Suppose that a map $\lambda_g: X \rightarrow X$ is defined for each element $g \in G$. I say that a monoid action $(X, G, \lambda)$ is the map such

$$ \lambda_e(a) = a \text{ for all } a \in X $$
{% include statement/end %}

From this simple action we can define a equivalence relationships between elements of $G$. This relationship is foundational to identify pitch pair (or in general pitch sets) as equivalent.

{% include statement/proposition name="equivalent actions" markdown="block" %}
Given a monion action $(X, G, \lambda)$ we define the relation $\stackrel{a}{\sim}$ on $G$ as

$$g \stackrel{a}{\sim} h \text{ iff } \lambda_g(a) = \lambda_h(a)$$ 

for $g, h \in G$ and an $a \in X$ and it is a equivalence relationship.[^2] Moreover, I say that $g \stackrel{a}{\sim} h$ are equivalent (or equivalent actions) on $a$.  
{% include statement/end %}

Next, we would like to identify all elements of a set that equivanlent actions to an action given by $h \in G$ over a $a \in X$.

{% include statement/definition name="set of equivalent actions" markdown="block" %}
I say that the set 

$$ E[h,a] = \left\{g \in G | \lambda_g(a) = \lambda_h(a)\right\}$$

is the set of all equivalent actions tp $\lambda_h(a)$ from $h \in G$ and $a \in X$.
{% include statement/end %}

By definition, this set have the following properties

* $h \in E[h, a]$
* $E[G, a] = G$
* $E[e, a] = \text{Stab}_{\lambda}(a) = G_a$.

{% include statement/remark name="stabilizer" markdown="block" %}
For conviniance I may use either $\text{Stab}_{\lambda}(a)$ or shorthand $G_a$[^100] to describe the estabilizer of action over $a$ defined as $G_a = \left\\{g \in G \vert \lambda_g(a) = a \right\\}$
{% include statement/end %}

The follow proposition I start connecting the concepts from group action with the more general monoid actions.

{% include statement/proposition name="equivalent set of group actions" markdown="block" %}
Given a **group** action $(X, G, \lambda)$ the set of equivalent actions $E[h,a] = hG_a$ for $h \in G$ and $a \in X$.
{% include statement/end %}

The proof follows from group action equality $\lambda_g(a) = \lambda_h(a)$ iff

$$ 
\begin{aligned}
\lambda_{h^{-1}g}(a) &= \lambda_{h^{-1}} \circ \lambda_{g}(a) \\
                     &= \lambda_{h^{-1}} \circ \lambda_{h}(a) \\
                     &= \lambda_{h^{-1}h}(a) = \lambda_{e}(a) = a
\end{aligned}
$$

and therefore $h^{-1}g \in G_a$ or $g \in hG_a$ for any $g \in G$ so $E[h,a] \subset G_a$. Now, if I assume that there is a $g \in hG_a$ such as is not in $E[h,a]$ we get a contradiction because
$$ 
\begin{aligned}
\lambda_{h^{-1}g}(a)                 &= a \\
\lambda_h \circ \lambda_{h^{-1}g}(a) &= \lambda_h(a) \\
\lambda_g(a)                         &= \lambda_h(a)
\end{aligned}
$$

## Fundamental domain

At this point, we find a way to identify as identical elements of $G$ based on the action over an element $a \in X$. We would like now 

## References

[^1]: For definition of monoid and references see ["Group actions and tuning systems"]({% post_url 2022-04-04-tuning-systems %})
[^2]: Definition 3.2 of [^100].
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
