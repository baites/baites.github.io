---
layout: post
title: An algebra for orbichords I (Fundamental actions)
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

I explained in the previous post that the main issue we found with group actions was the composition rule base on the group product does not always applied.[^3] Therefore, I start defining more generic actions based monoids without proposing any type of composition.

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


{% include statement/example name="equivalent set of real pitch dyad" markdown="block" %}
Using the dyad define in the previous post[^3] and setting as tandard pitch $0 \in \mathcal{S}$, the action is $\phi(\mu,\delta) = \lambda_{(\mu,\delta)}(0)$

$$ \phi(\mu,\delta) = \frac{1}{2}\left[(\mu-\vert\delta\vert) \mathbf{e}\\_1 + (\mu+\vert\delta\vert) \mathbf{e}\\_2\right] $$

For a value $h = (\mu, \delta)$, the the set of equivalent points $E[h,0] = \left\\{(\mu, \delta), (\mu, -\delta)\right\\}$.
{% include statement/end %}


{% include statement/definition name="images" markdown="block" %}
We sat that any $g^{\prime} \in G$ is image of $g \in G$ if also $g^{\prime}$ is a equivalent action relative to a $a \in X$ or $g^{\prime} \in E[g,a]$. As such, we say also call $E[g,a]$ the set of images of $g$ due to actions on $a$.
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

At this point, we find a way to identify identical elements of $G$ based on the action over an element $a \in X$. I would like now to find a set of elements in $G$ that does not result the same action from when starting from a element $a \in G$.

{% include statement/definition name="fundamental domain" markdown="block" %}
The set $D_a \subset G$ is a fundamental domain relative to $a \in G$ if

1. $e \in D_a$
1. $E[h,a] = E[g,a]$ iff $h = g$ for any $h,g \in D_a$.
1. $G = \bigcup_{h \in D_a} E[h,a]$
{% include statement/end %}

The next proposal stablish that the equivalent set of two distinc elements of fundamental domain $h,g \in D_a$ for $h \neq g$ cannot overlap. 

{% include statement/proposition name="no overlap between images" markdown="block" %}
Equivalent actions for two distinct elements $g,h \in D_a$ for $h \neq g$ do not overlap or $E[h,a] \cap E[g,a] = \emptyset$.  
{% include statement/end %}

The proposal can also be interpreated as elements from foundamental domain are not images of each other. The counter part when looking at the more narrow group actions is given by the followind proposition.

{% include statement/example name="fundamental domain of real pitch dyad" markdown="block" %}
Using the dyad define in the previous post[^3] and setting as tandard pitch $0 \in \mathcal{S}$, the fundamental domain 

$$ D_0 = \left\{(\mu, \delta) \in \mathbb{R} | \delta \geq 0 \right\}. $$
{% include statement/end %}

## Equivalence space

I can now then collect each non overlapping $E[h,a]$ sets under one set resulting the in the following definition.

{% include statement/definition name="fundamental domain" markdown="block" %}
Given a monion action $(X, G, \lambda)$, and $a \in X$ and the foundamental domain $D_a$, I call the set

$$ G/E_a = \left\{E[h,a] \text{ | } h \in D_a \right\} $$

the *equivalent-action space* or simply *the equivalance space*.
{% include statement/end %}

This 

{% include statement/theorem name="monion actions are equivalent spaces" markdown="block" %}
Given a monion action $(X, G, \lambda)$ and $a \in X$ the equivalance space $G/E_a$ is monion-action isomorphic to action orbit $\lambda_G(a)$ 

$$ \lambda_G(a) \simeq G/E_a $$

where the bijection mapping both set is $f: G/E_a \rightarrow \lambda_G(a); E[h,a] \mapsto \lambda_h(a)$. 
{% include statement/end %}

Proof: $f$ is a well-define injection because by definition

$$ h=g \iff E[h,a] = E[g,a] \text{ for any } h,g \in D_a $$

moreover $f$ surjects because 

$$ 
\begin{aligned}
\lambda_{D_a}(a) &= \bigcup_{h \in D_a} \{ \lambda_h(a) \} \\
                 &= \bigcup_{h \in D_a} \bigcup_{g \in E[h,a]} \{ \lambda_g(a) \} \\
                 &= \bigcup_{g \in \bigcup_{h \in D_a} E[h,a]} \{ \lambda_g(a) \} \\
                 &= \bigcup_{g \in G} \{ \lambda_g(a) \} = \lambda_G(a)
\end{aligned}
$$

where we use the property set with one element $\\{ \lambda_h(a) \\}$ is trivially identical to the union $\bigcup_{g \in E[h,a]} \\{ \lambda_g(a) \\}$ of the set of one transformation over equivalence set $E[h,a]$ and property of fundamental domain $G = \bigcup_{h \in D_a} E[h,a]$.

## Fundamental actions

The next logical step is to add more structure to the monion action to recover some of the benefits of groups action composition. For that I need to define the map that takes any element $g \in G$ into a element of $D_a$ that has equivalent action.

{% include statement/definition name="fundamental domain map" markdown="block" %}
The function $\pi_a: G \rightarrow D_a; g \mapsto h$ such $g \in E[h,a]$ maps any point in $G$ into the fundamental domain $D_a$.
{% include statement/end %}

This map has the following properties:

* $g \in D_a$ then $\pi_a(g) = g$.
* $\pi_a(g) \in D_a$ so $\pi_a \circ \pi_a(g) = \pi_a(g)$.
* $\pi_a\left(E[h,a]\right) = h$ for any $h \in D_a$.
* $\pi_a\left(E[g,a]\right) = h$ for any $g \in G$ and $h = \pi_a(g)$.

Using this map we can create a new composition rule and thereofore a new type of action.

{% include statement/definition name="fundamental action" markdown="block" %}
Given a moniod action $(X, G, \lambda)$ and its fundamental domain $D_a$ relative to $a \in X$. I assume this case that $G$ is a group $(G, \cdot, e)$. I say the action is a *fundamental* or a *fundamental action* if also comply with the following composition rule

$$ \lambda_g \circ \lambda_h(a) = \lambda_{g\cdot\pi_a(h)}(a) $$
{% include statement/end %}

{% include statement/example name="fundamental action in real pitch dyad" markdown="block" %}
The figure below ....

{% include image file="action-on-2d-real-dyad-v2.png" scale="80%" %}
{% include statement/end %}

Let see how fundamental action include group actions.

{% include statement/proposition name="group action are fundamental" markdown="block" %}
Group actions are fundamental actions!
{% include statement/end %}

**Proof:** By definition $\pi_a(h) = k$ means that $h \in E[k,a]$ for $k \in D_a$, and I showed that $E[k,a] = kG_a$. Applying the composition rule of group actions you get then

$$ 
\begin{aligned}
\lambda_g \circ \lambda_h(a) &= \lambda_{g\cdot h}(a) = \lambda_{g\cdot E[k,a]}(a) \\
                             &= \lambda_{g\cdot kG_a}(a) = \lambda_{g\cdot k} \circ \lambda_{G_a}(a) \\
                             &= \lambda_{g\cdot k}(a) = \lambda_{g\cdot \pi_a(h)}(a)
\end{aligned}
$$

## Summary

I developed the necessesary tools to define a new class of actions based on groups and the identification of some member of the group as equivalent. I call this action fundamental as their definition required the notion of fundamental domains. Those domains contains all the member of a group that result in distict actions over a given element on set where actions are applied. I illustrated how all these definitions can be apply to *real pitch dyad*. I also showed group actions are also fundamental.

In the next post I will complete the equivalent to *Transitive actions are homogeneous spaces* theorem[^4] for fundamental action. As such en generalizing the most important concept of group action to fundamental ones that allow for identification of group members as equivalent!

## References

[^1]: For definition of monoid and references see ["Group actions and tuning systems"]({% post_url 2022-04-04-tuning-systems %})
[^2]: Definition 3.2 of [^100].
[^3]: [A pair of pitches with a twist]({% post_url 2025-12-10-a-pair-of-pitches-with-a-twist %})
[^4]: [Tuning systems are homogeous spaces]({% post_url 2022-07-25-tuning-systems-are-homogeneous-spaces %})
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
