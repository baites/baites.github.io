---
layout: post
title: Tuning systems by simple actions
date: 2029-02-06 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In the previous blog of this series[^1], I showed that building tuning systems as orbit of a action group given by $G$ in single pitch space $\mathcal{S}$ from standard pitch $a$ has an equivalent counter part as an action in homogenous spaces $G/G_a$. Both set of actions are related by group-action isomorphism. The advangate of actions over homogenous spaces is that they can be defined exclusively using elements of the group $G$.

Action group on a single pitch space add then some extra structure that can describe music from it. For example, I will show in following blogs how using action groups on single pitch space, I can build arbitrary scales such as twelfe-tone equal temperament scale know also as the chromatic[^2].

In this blog I will show that for less generic actions, I can reformulate the definition of tuning system almost exclusively on properties of group $G$. This formulation uses another famous abstract algebra theorem: the First Isomorphism Theorem for Groups.

## Left group action

When I say simpler action I mean that that action is given by left group action.

{% include statement/definition name="left action group"  markdown="block"%} If $G$ is a group with identity $e$ and $X$ is a set, then the left action $\cdot$ of $G$ on $X$ is a function $\cdot: G \times X \rightarrow X$ that satifies the following properties:

* identity: $e \cdot x = x$
* compatibility: $g \cdot (h \cdot x) = (gh) \cdot x$

for all $g, h \in G$ and $x \in X$. It is important to notice that $gh$ is short notation for group mutiplication between $g$ and $h$.[^3]
{% include statement/end %}

Therefore, using this definition I say $\lambda_g(x)$ is *simple action* if its given by a left action group

$$
\lambda_g(x): X \rightarrow X; x \mapsto \phi(g)\cdot x
$$

where $\phi: G \rightarrow G$ is a function from group $G$ into itself that needs to comply with some rules. Group action composition rule says that $\lambda_{gh}(x) = \lambda_g(\lambda_h(x))$ for all $g, h \in G$ and $x \in X$. It follows then

$$
\begin{align*}
  \lambda_{gh}(x) &= \lambda_g(\lambda_h(x)) \\
  \phi(gh) \cdot x &= \phi(g) \cdot (\phi(h) \cdot x) \\
  \phi(gh) \cdot x &= (\phi(g)\phi(h)) \cdot x \\
\end{align*}
$$

where in the last equation I use the compatibility property of the left group action. Last equalities are possible if and only if

$$
\phi(gh) = \phi(g)\phi(h)
$$

Group definition also requires that $\lambda_e(x) = x$ or

$$
\phi(e) = e
$$

Lastly, if $g = h^{-1}$ that is the inverse of $h \in G$, then $e = \phi(e) = \phi(h^{-1}h) = \phi(h^{-1}) \phi(h)$ implying that

$$
\phi(h^{-1}) = \phi(h)^{-1}.
$$

A function comply with all these properties is know as a group homomorphism[^4].

## Tuning systems of simple acctions

As describe in previous blogs, tuning systems are action group orbits $\lambda_G(a)$ where $a$ is standard pitch. As such

## Theorem

$$
\begin{CD}
   G @>\phi>> G \\
@VsVV @AAiA \\
   G/Ker_{\phi} @>>\simeq> \phi(G)
   \end{CD}
$$

## References

[^1]: [Blog about tuning systems]({% post_url 2029-02-03-tuning-systems %})
[^2]: [Twelve-tone equal temperament](https://en.wikipedia.org/wiki/12_equal_temperament)
[^3]: [Left group action](https://en.wikipedia.org/wiki/Group_action#Left_group_action)
[^4]: Definition 5.1 of [^100].
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
