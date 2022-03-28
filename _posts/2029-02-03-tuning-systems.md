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

## Introduction

In a previous blog I introduced the notion of [simple pitch space]({% post_url 2022-02-21-single-pitch-space %}). This blog aims to build subsets of this space that can be useful to express musical concepts.

## Standard pitch and actions

Music is built from a standard pitch[^1]. Musicians use a standard pitch as a reference to define other pitches, often grouped in scales[^2]. Luthiers tune instruments around a standard pitch so that any different pitch is somehow related to that standard pitch. It is easy to define a standard pitch from a simple pitch space as follows.

{% include statement/definition name="standard pitch" %}
A standard pitch $a$ is an element of the simple pitch space $\mathcal{S}$ with an arbitrarely chosen frequency $f_0 \in \mathbb{R}_{>0}$, meaning $f(a) = f_0$.
{% include statement/end %}

Starting from a starndard pitch $a$ and a map $\lambda : \mathcal{S} \rightarrow \mathcal{S}$, I can construct another pitch $b \in \mathcal{S}$ as $b = \lambda(a)$. You can say that a pitch $b$ is the result of the action of the map $\lambda$ over the reference pitch $a$.

I can now extend this idea to create more than one pitch. Lets define a map $\lambda_x : \mathcal{S} \rightarrow \mathcal{S}$ for each element $x$ of a set $X$. Under these maps, each element of $X$ defines possibly different actions on the standard pitch. For example, give two elements $x, y \in X$, I can define two pitches $b, c \in \mathcal{S}$ by the following actions on the standard pitch $b = \lambda_x(a)$ and $c = \lambda_y(a)$. Therefore, it seems possible to use actions to build a set of pitches from a standard pitch useful for music representation.

One thing it would be nice to express is the trivial identity action that leaves the standard pitch untouched. The element $e \in X$ is the identity action if $\lambda_e(a) = a$ where $\lambda$ is the action maps described above.

Assume that you construct a pitch $b = \lambda_x(a)$ for an action on standard pitch with $x \in X$. I could now also create another pitch $c$ by acting on $b$ or $c = \lambda_y(b)$ for some $y \in X$. It would be desirable the pitch $c$ can be also the result of an action on the standard pitch or $c = \lambda_z(a)$ for a $z \in X$. This property implies that $\lambda_z(a) = \lambda_y(\lambda_x(a))$, meaning $\lambda_z$ is the function composition $\lambda_y \circ \lambda_x$. If this property holds for any combination of $x, y \in X$, it is possible to decribe every pitch as action on standard pitch, or alternative, as succession of actions starting from the standard pitch.

## Groups

Actions with the above properties are known as group actions. Defining these actions requires first to explain what in algebra is known as a group.

{% include statement/definition name="Abstract group" markdown="block" %}
A group $(G, ., e)$ is a set $G$ with a binary operator (sometimes referred as group product) $\cdot$ satisfying the following properties:[^4]
1. **Closure:** $x \cdot y$ lies in $G$ for all $x, y \in G$;
2. **Associativity:** $x \cdot (y \cdot z) = (x \cdot y) \cdot z$ for all $x, y, z \in G$;
3. **Indentity:** There is an element $e$ in $G$ with $e \cdot x = x \cdot e$ for all $x \in G$;
4. **Inverses:** For each $x \in G$, there is a $x^{-1} \in G$ with $x \cdot x^{-1} = e = x^{-1} \cdot x$.
{% include statement/end %}

There are also sets that partially comply with some of the property to be a group. I am not planning to use much of these intermediated objects. However, their names often appear in the literature, so I think it is good to define them. Any set with a multiplication that satisfies properties 1-2 is known as **semigroups**[^5]. A **monoid** is a semigroup with an identity element, meaning it satisfy properties 1-3[^6].

Let me provide some examples of a group that will be important later on.

{% include statement/example name="Real numbers under addition" %}
The real numbers form a group $(\mathbb{R}, +, 0)$ with addition as commutative operator. The inverse or *additive inverse* of a real number r is its negation -r.[^7]
{% include statement/end %}

{% include statement/example name="Multiplication on nonzero reals" %}
Under multiplication, the nonzero real numbers form a commutative group $(\mathbb{R}^{*}, \cdot, 1)$.[^8]
{% include statement/end %}

{% include statement/remark name="Group multiplication" %}
The group binary operator $\cdot$ is called *group multiplication* or simply *multiplication*. However, as shown in the previous examples, this operator is not always the traditional multiplication operator.
{% include statement/end %}

## Group actions

Having the definition of group, we can now define action group as follow.

{% include statement/definition name="group action" markdown="block" %}
Let $X$ be a set and let $(G, \cdot, e)$ be a group. Suppose that a map $\lambda_g: X \rightarrow X$ is defined for each element $g \in G$. Then there is a group action of $G$ on $X$ if and only if

1. $\lambda_e(x) = x$ and
2. $\lambda_{g \cdot h}(x) = \lambda_g(\lambda_h(x))$

for all $x  \in X$ and $g, h \in G$.[^9]
{% include statement/end %}

In the next section, I will show that knowing the subset of all elements of $X$ given by all actions of $G$ on one element $x \in X$ is essential. This concept is captured the notion of group action *orbits*.

{% include statement/definition name="orbit" %}
Let $(X, G, \lambda)$ be an action of a group $G$ on a set X. For an element $x \in X$, the *orbit* of $x$ is the set
$$
\lambda_G(x) = \big\lbrace \lambda_g(x) \vert g \in G \big\rbrace
$$
of images of $x$ under the actions $\lambda_g$ of the elements $g \in G$.[^10]
{% include statement/end %}

## Tuning systems

The plan is to use action group orbits to define an interesting subset of pitches from a single pitch space. I plan to do that to explain what I call a tuning system. This system is the only concept that is my own. It is my way of applying group action to describe a collection of pitches.

{% include statement/definition name="tuning system" %}
Let $(\mathcal{S}, G, \lambda)$ be an action of a group $G$ on the single pitch space $\mathcal{S}$. Given a standard pitch $a \in \mathcal{S}$, I say that the tuning system notated $\mathcal{T}$ as the orbit $\lambda_G(a)$.
{% include statement/end %}

The idea with tuning system is to use a given group action $(\mathcal{S}, G, \lambda)$ with a group $G$ with  its binary operator to carve a subset of pitches $\mathcal{T}$ by all possible actions generated by elements of $G$ starting from a standard pitch $a \in \mathcal{S}$, meaning $\mathcal{T} = \lambda_G(a)$. Tuning systems are then an example of action groups **restricted to an orbit** where we can define $(\mathcal{T}, G, \lambda)$ as an action group of $G$ on $\mathcal{T}$.[^11]

An important property of action groups $(\mathcal{T}, G, \lambda)$ is that they are *transitive*. This means that $\mathcal{T}$ is not empty and for each pair of elements $b, c \in \mathcal{T}$ there is an element $g \in G$ such $c = \lambda_g(b)$.[^12] This is exactly the property we identified a few sections back as important to describe meaningful subsets of the single pitch space!

## Summary

Starting from single pitch space $\mathcal{S}$ I do the following.

* I choose a standard pitch $a$ of $\mathcal{S}$.
* I introduce the group action $(\mathcal{S}, G, \lambda)$ of $G$ on $\mathcal{S}$.
* I define a tuning system as the set $\mathcal{T} \subseteq \mathcal{S}$ given by orbit $\lambda_G(a)$.
* I show there is also action group $(\mathcal{T}, G, \lambda)$ of $G$ on $\mathcal{T}$ that is transitive!

In the next blog, I will show some examples of tuning systems that will be useful to define interesting collections of pitches.

## References

[^1]: I like to warn the reader that most of this blog centers around the western musical tradition that I experienced as I grew up. Western music tradition is my current focus on interest. I expect some of concepts I discussed can be extended to other traditions. However, I am not sure of it.
[^2]: [Wiki entry: Scale(music)](https://en.wikipedia.org/wiki/Pitch_(music))
[^3]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
[^4]: Definition 4.14 of [^3].
[^5]: Definition 4.1 of [^3].
[^6]: Definition 4.7 of [^3].
[^7]: Example 4.16 of [^3].
[^8]: Example 4.17 of [^3].
[^9]: Proposition 10.5 of [^3].
[^10]: Section 10.2 "Orbits" from [^3].
[^11]: Example 10.18 of [^3].
[^12]: Section 10.3 "Transitive actions" from [^3].
