---
layout: post
title: Group actions and tuning systems
date: 2029-02-03 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

# Introduction

In a previos blog I introduced the notion of [simple pitch space]({% post_url 2029-02-02-single-pitch-space %}). The goal in this blog is to build subsets of this space that can be useful to express musical concepts.

# Standard pitch and actions

Music is often build from a standard pitch[^1]. Musicians use a standard pitch as reference to define other pitches often group in scales[^2]. Luthiers tune instruments around a standard pitch in such a way that any other pitch produce by thier instruments is somehow related to it. From a simple pitch space it is easy define a standard pitch as follow.

{% include statement/definition name="standard pitch" %}
A standard pitch $a$ is an element of the simple pitch space $\mathcal{S}$ with an arbitrarely chosen frequency $f_0 \in \mathbb{R}_{>0}$, meaning $f(a) = f_0$.
{% include statement/end %}

Starting from a starndard pitch $a$ and a map $\lambda : \mathcal{S} \rightarrow \mathcal{S}$, I can construct another pitch $b \in \mathcal{S}$ as $b = \lambda(a)$. You can say that a pitch $b$ is the result of the action of the map $\lambda$ over the reference pitch $a$.

I can now extend this idea to create more than one pitch. Lets define a map $\lambda_x : \mathcal{S} \rightarrow \mathcal{S}$ for each element $x$ of a set $X$. Under these maps, each element of $X$ defines possibly different action on standard pitch. For example, give two elements $x, y \in X$, I can define two pitches $b, c \in \mathcal{S}$ by the following actions on the standard pitch $b = \lambda_x(a)$ and $c = \lambda_y(a)$. Therefore, it seems possible to use actions to build set of pitches from a standard pitch useful for music representation.

One thing it would be nice to express is the trivial identity action that leave the standard pitch untouch. This idea can be annotated by assuming there is an element $e \in X$ such that $\lambda_e(a) = a$ where $\lambda$ is the action maps described above.

Assume that you construct a pitch $b = \lambda_x(a)$ for an action on standard pitch with $x \in X$. I could now also create another pitch $c$ by acting on $b$ or $c = \lambda_y(b)$ for some $y \in X$. It would be desirable the pitch $c$ can be also the result of an action on the standard pitch or $c = \lambda_z(a)$ for a $z \in X$. This property implies that $\lambda_z(a) = \lambda_y(\lambda_x(a))$, meaning $\lambda_z$ is the function composition $\lambda_y \circ \lambda_x$. If this property holds for any combination of $x, y \in X$, it is possible to decribe every pitch as action on standard pitch, or alternative, as succession of actions starting from the standard pitch.

# Groups

Actions with the above properties are known as group actions. Defining these actions requires first to explain what in algebra is known as a group.

{% include statement/definition name="Abstract group" markdown="block" %}
A group $(G, ., e)$ is a set $G$ with a binary operator $\cdot$ satisfying the following properties:[^4]
1. **Closure:** $x \cdot y$ lies in $G$ for all $x, y \in G$;
2. **Associativity:** $x \cdot (y \cdot z) = (x \cdot y) \cdot z$ for all $x, y, z \in G$;
3. **Indentity:** There is an element $e$ in $G$ with $e \cdot x = x \cdot e$ for all $x \in G$;
4. **Inverses:** For each $x \in G$, there is a $x^{-1} \in G$ with $x \cdot x^{-1} = e = x^{-1} \cdot x$.
{% include statement/end %}

There are also sets that partially comply with some of the property to be a group. I am not planning using much of these intermediated object. However, their names appear often in the literature so I think there is some value making a reference about them. Any set with a multiplication that satisfy properties 1-2 are know as **semigroups**[^5]. If a **monoid** is a semigroup with an identity element or satisfy properties 1-3[^6].

Let me provide some examples of a group that will be important later on.

{% include statement/example name="Real numbers under addition" %}
The real numbers form a group $(\mathbb{R}, +, 0)$ with addition as commutative operator. The inverse or *additive inverse* of a real number r is its negation -r.[^7]
{% include statement/end %}

{% include statement/example name="Multiplication on nonzero reals" %}
Under multiplication, the nonzero real numbers form a commutative group $(\mathbb{R}_{>0}, \cdot, 1)$.[^8]
{% include statement/end %}

# Group actions

Having the definition of group, we can now define action group as follow.

{% include statement/definition name="group action" markdown="block" %}
Let $X$ be a set and let $(G, \cdot, e)$ be a group. Suppose that a map $\lambda_g: X \rightarrow X$ is defined for each element $g \in G$. Then there is a group action of $G$ on $X$ if and only if

1. $\lambda_e(x) = x$ and
2. $\lambda_{g \cdot h}(x) = \lambda_g(\lambda_h(x))$

for all $x  \in X$ and $g, h \in G$.[^9]
{% include statement/end %}

# References
[^1]: I like to warn the reader that most of this blog centers around western musical tradition. This is the tradition I grew up and therefore, the tradition I am more familiar with. Western music tradition is my current focus on interest. It might be possible that some of the concepts in this blog can be extended to other traditions. However, I am not ceirtain of it.

[^2]: [Wiki entry: Scale(music)](https://en.wikipedia.org/wiki/Pitch_(music))
[^3]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
[^4]: Definition 4.14 of [^3].
[^5]: Definition 4.1 of [^3].
[^6]: Definition 4.7 of [^3].
[^7]: Example 4.16 of [^3].
[^8]: Example 4.17 of [^3].
[^9]: Proposition 10.5 of [^3].