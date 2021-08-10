---
layout: post
title: Tuning systems are homogeous systems
date: 2029-02-05 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In this blog I discuss the necesary tools to understand the structure of the a tuning system from its action group. The beatiful this is that these tools are basically the most important theorems of abstract algebra:

* the theorem that proves transitive actions are homogenoeous spaces and later,
* the first isomorphism theorem for groups!

This is likely a long blog. However, I will try provide the main argument as simple as possible. I will delegate the details to the references.

## Relationships between two actions

I defined tuning systems as an orbit of an action groups.[^1] It will be then convinient to find a way to related two different actions. Through out these relationship we hope to learn more about the nature of the tuning systems.

{% include statement/definition name="group action homomorphism" markdown="block" %}
Given two transformation groups $(X, G, \lambda)$ and $(Y, G, \mu)$ with a common group $G$, a function $f: X \rightarrow Y$ is called a group action homomorphism if the following equation holds for any $g \in G$ and $x \in X$[^2]:
$$
f(\lambda_g(x)) = \mu_g(f(x))
$$
{% include statement/end %}

The interpretation is of map straightforward. The homomorphism related both actions as follow. You can choose an element $x \in X$ and map it to an another element $y \in Y$ by $y = f(x)$. Assume now that a group acts on $x$ resulting in a element $x' = \lambda_g(x)$ and also, the other group act on $y$ resulting in a element $y' = \mu_g(y)$ for any $g \in G$. If $f$ is a group action homomorphism then it also true that $y' = f(x')$. In a way, the homomorphism $f$ relates the results of both actions under the same group.

{% include statement/definition name="group action isomorphism"%}
Given two transformation groups $(X, G, \lambda)$ and $(Y, G, \mu)$ with a common group $G$, a group action homomorphism $f: X \rightarrow Y$ which is also bijective is called a group action isomorphism between the set $X$ and $Y$. In this case we say that both sets are group action isomorphic and denote $X \simeq Y$.
{% include statement/end %}

## Subgroups and cosets

Within a group you can find a subset that is also a group. The finition is straight forward.

{% include statement/definition name="subgroup"%}
A subset $H \subset G$ is a subgroup of $(G, \cdot, e)$ if $H$ forms a group $(H, \cdot, e)$, that is a $x \in H$ implies that its inverse $x^{-1}$ is also in $H$.
{% include statement/end %}

A subgroup $H$ can be useful to partition an original $G$ group in to subsets known as cosets. Given a element $x$ of $G$ I can define

$$
Hx = \big\lbrace n \cdot x | n \in H \big\rbrace \text{ and } xH = \big\lbrace x \cdot n | n \in H \big\rbrace
$$

where the sets $Hx$ and $xH$ are known as the *right* and *left cosets* of the subgroup $H$ with element $x$. For my discussion I just need to concentrate in the collection of all left cosets for each element $x \in G$ defined as

$$
G/H = \big\lbrace xH | x \in G \big\rbrace \text{.}
$$

It is important to understand that $G/H$ is a set of sets. For a collection of elements $x_1,x_2,...,x_k \in G$ there is associated a collection of sets $x_1H, x_2H,...,x_kH \in G/H$. The set (of sets) $G/H$ is called homogeneous space.[^4] Each of the sets of $G/H$ can be connected by an action group.

{% include statement/proposition name="action on cosets"%}
Given a homogenous space $G/H$ of a group $G$ with a subgroup $H$, then there is a *transitive* action $(G/H, G, \lambda)$ define by the function $\lambda_g: G/H \rightarrow G/H; xH \mapsto gxH$ for each $g$ in $G$.[^5]
{% include statement/end %}

This proposition means that if we start from $x, y, g \in G$ such $y = gx$, then the coset $xH$ can be transformed to the coset $yH$ simply by the action $\lambda_g(xH) = gxH = yH$. In words, all the cosets of a homogeneous space can be reached by transitive actions from any other coset.

## Refernces

[^1]: TODO
[^2]: Katsuo Kawakubo, The Theory of Transformation Groups. Oxford University Press, 1991. Chap 1, page 5. In the book this function is known as *G-map* or *equivariant map*. However, I think a better terminology would be group actio (or action) homomorphism. This is more consistent with the Cathegory Theory approach of calling morphism to relationship between objects.
[^3]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
[^4]: Definition 10.20 of [^3].
[^5]: Proposition 10.19 of [^3].
