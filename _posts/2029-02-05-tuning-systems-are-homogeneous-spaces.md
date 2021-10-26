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

It is important to understand that $G/H$ is a set of left cosets. For a collection of elements $x_1,x_2,...,x_k \in G$ there is associated a collection of cosets $x_1H, x_2H,...,x_kH \in G/H$. The set (of cosets) $G/H$ is called homogeneous space.[^3] The next propositon shows that each of the cosets of $G/H$ can be connected by an action group.

{% include statement/proposition name="action on cosets"%}
Given a homogenous space $G/H$ of a group $G$ with a subgroup $H$, then there is a *transitive* action $(G/H, G, \mu)$ define by the function $\mu_g: G/H \rightarrow G/H; xH \mapsto gxH$ for each $g$ in $G$.[^4]
{% include statement/end %}

This proposition means that if we start from $x, y, g \in G$ such $y = gx$, then the coset $xH$ can be transformed to the coset $yH$ simply by the action $\mu_g(xH) = gxH = yH$. In words, all the cosets of a homogeneous space can be reached by transitive actions from any other coset.

Two extreme examples of homogenous spaces are noted specially. The homogeneous space $G/G$ (where the subgroup is $G$ itself) is *trivial*[^5] with *trivial action*[^6] $\mu_g(x) = x$. Alternative, the homogeneous space $G/\lbrace e \rbrace$ (where $e$ is $G$ identity element) is *a simple representation* of $G$ because it is just to write every $x \in G$ as singleton set $\lbrace x \rbrace$[^7].

## Transitive actions are homogenous spaces

Let me summary what was described so far. First I showed the way on how to relate to different actions using *group action homomorphism*. Second, I find that for a given subgroup $H$ of a group $G$ we can define a transitive action. This action is written exclusively as acting on cosets of $G/H$ **without referencing any other set!**

As result, one can wonder if it might be possible to relate any transitive action on an arbitrary set to an action over homogeneous space. The answer is yes and it is a *central* (perhaps fundamental) theorem of action groups and I will state it as follow.

{% include statement/theorem name="Transitive actions are homogeneous spaces" markdown="block"%}
Let $(X, G, \lambda)$ be a transitive action of a group $G$ on an nonempty set $X$. For each element $a$ of $X$, considere the stabilizer of $G_a$ under this action. Let $(G/G_a, G, \mu)$ be the homogeneous space action of $G$ on $G/G_a$. Then $X$ and $G/G_a$ are group action isomorphic[^8]

$$
X \simeq G/G_a
$$

where the bijective function mapping both sets is $f: G/G_a \rightarrow X; gG_a \mapsto \lambda_g(a)$
{% include statement/end %}

Now for action group $(X, G, \lambda)$ and for each element $a$ of $X$ I can define the orbit $\lambda_G(a)$. I showed in a [early blog of this series]({% post_url 2029-02-03-tuning-systems %}) that by definition the action of $G$ on elements of the orbit $\lambda_G(a)$ is a transitive action! As result we have the following collorary.

{% include statement/collorary name="Orbits are isomorphic homogeneous spaces" markdown="block"%}
Let $(X, G, \lambda)$ be a transitive action of a group $G$ on an nonempty set $X$. For each element $a$ of $X$, considere  the orbit $\lambda_G(a)$ and the stabilizer of $G_a$ under this action. Then the orbit $\lambda_G(a)$ is group-action isomorphic to the homogeneous space $G/G_a$[^9]

$$
\lambda_G(a) \simeq G/G_a
$$
{% include statement/end %}

The next figure is a graphical representation of the theorem statement.

{% include image file="mt-action-group-fundamental-theom.png" scale="90%" %}

As you can see all elements $g \in G_a$ leave the element $a \in X$ the same. So, I interprate this as all the elements of $G_a$ are somawhat equivalent in the sense that when acting on $a$ there result is always $a$. Now each coset $xG_a$ also produces another set of equivalent actions that when takes $a$ into $\lambda_x(a)$. The process allows to create group-action isomorphic between homogeneous space and all point of action group orbit. We can then describe the set from by the trajectory by studing its related homogeneous space.

## Tuning systems are homogenous spaces

The application of these ideas to music is straightforward from my definition of tuning systems. This definition basically says tuning systems are basically action group orbits in the single pitch space.[^1] It follows then next collorary.

{% include statement/collorary name="tuning systems are homogenous spaces" %}
Let $(\mathcal{S}, G, \lambda)$ be an action of a group $G$ on the single pitch space $\mathcal{S}$. Let $\mathcal{T}$ be the tuning system given by the orbit $\lambda_G(a)$ where $a \in \mathcal{S}$ is the standard pitch. It follows that the tuning system $\mathcal{T}$ is group action isomorphic to the homogeneous space $G/G_a$
$$
\mathcal{T} \simeq G/G_a
$$
where we say in this case that $G/G_a$ its pitch class.
{% include statement/end %}

Arm with collorary we can show now some of the arguments done for the simple tuning systems defined in the [previous blog of this series]({% post_url 2029-02-04-simple-tuning-systems %}). I can now put the description about structure of those tuning systems in stroger foundations.

{% include statement/example name="positive-real tuning system is isomophic with positive real numbers" markdown="block"%}
With action group $(\mathbb{R}\_{>0}, \cdot, 1)$ I defined positive-real tuning system as the orbit $\mathcal{T} = \lambda_{\mathbb{R}\_{>0}}(1)$ where $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; x \mapsto gx$ for any $g \in G$. It easy to see that the stabilizer around identity is the same with the identity itself $G_1 = \lbrace 1 \rbrace$. This means that $\mathcal{T} \simeq \mathbb{R}\_{>0}/\lbrace 1 \rbrace$ that is a simple representation of $\mathbb{R}\_{>0}$ in cosets $x\lbrace 1 \rbrace$ for $x \in \mathbb{R}\_{>0}$, or $\mathcal{T} \simeq \mathbb{R}\_{>0}$, and thefore its pitch class is $\mathbb{R}\_{>0}$.
{% include statement/end %}

The same argument applies for all the other simple tuning systems in previous blog because their stabilizers contains only the identity element of their respectively groups. As result the following statements are true:

* positive-real tuning system pitch class is $\mathbb{R}\_{>0}$,
* real tuning system pitch class is $\mathbb{R}$,
* equal temperament tuning system pitch class is $\mathbb{Z}$,
* $p_n$-limit tuning system pitch class is $\mathbb{Z}^n$.

## References

[^1]: [Blog about tuning systems]({% post_url 2029-02-03-tuning-systems %})
[^2]: Chap 1, page 5 of [^100]. In the book this function is known as *G-map* or *equivariant map*. However, I think a better terminology would be group actio (or action) homomorphism. This is more consistent with the Cathegory Theory approach of calling morphism to relationship between objects.
[^3]: Definition 10.20 of [^101].
[^4]: Proposition 10.19 of [^101].
[^5]: Example 10.8 of [^101].
[^6]: Chap 1, page 6 of [^101].
[^7]: Example 10.21 of [^101].
[^8]: Example 10.22 of [^101].
[^9]: Theorem 1.5 of [^100].
[^100]: Katsuo Kawakubo, The Theory of Transformation Groups. Oxford University Press, 1991.
[^101]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
