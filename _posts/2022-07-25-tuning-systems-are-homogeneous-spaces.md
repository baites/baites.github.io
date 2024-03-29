---
layout: post
title: Tuning systems are homogeous spaces
date: 2022-07-25 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In this blog, I discuss the necessary tools to understand the structure of a tuning system from its action group. The beauty is that the mathematical device I am using is a very important theorems of abstract algebra: the theorem that proves transitive actions are homogeneous spaces.

As usual, I provide the main argument as simply as I can make them. I delegate most of the details to the references.

## Relationships between two actions

I defined tuning systems as an orbit of an action group.[^1] It is then convenient to find a way to relate two different actions. Throughout this relationship, we hope to learn more about the nature of the tuning systems.

{% include statement/definition name="group-action homomorphism" markdown="block" %}
Given two action groups $(X, G, \lambda)$ and $(Y, G, \mu)$ with a common group $G$, a function $f: X \rightarrow Y$ is called a group-action homomorphism if the following equation holds for any $g \in G$ and $x \in X$[^2]:
$$
f(\lambda_g(x)) = \mu_g(f(x))
$$
{% include statement/end %}

The interpretation of the map is straightforward. The homomorphism relates both actions as follows. You can choose an element $x \in X$ and map it to an another element $y \in Y$ by $y = f(x)$. Assume now that a group acts on $x \in X$ resulting in $x' = \lambda_g(x)$ and also, and group act on $y \in Y$ resulting in $y' = \mu_g(y)$ for any $g \in G$. If $f$ is a group-action homomorphism then it also true that $y' = f(x')$. In a way, the homomorphism $f$ relates the results of both actions under the same group.

{% include statement/definition name="group-action isomorphism"%}
Given two action groups $(X, G, \lambda)$ and $(Y, G, \mu)$ with a common group $G$, a group-action homomorphism $f: X \rightarrow Y$, that is also bijective, is called a group-action isomorphism between the set $X$ and $Y$. In this case, we say that $X$ and $Y$ are isomorphic using the notation $X \simeq Y$.
{% include statement/end %}

## Subgroups and cosets

Within a group, you can find a subset that is also a group.

{% include statement/definition name="subgroup"%}
A subset $H \subset G$ is a subgroup of $(G, \cdot, e)$ if $H$ forms a group $(H, \cdot, e)$, that is a $x \in H$ implies that its inverse $x^{-1}$ is also in $H$.
{% include statement/end %}

A subgroup $H$ can help partition an original $G$ group into subsets known as cosets. Given an element $x$ of $G$, I can define

$$
Hx = \big\lbrace n \cdot x | n \in H \big\rbrace \text{ and } xH = \big\lbrace x \cdot n | n \in H \big\rbrace
$$

where the sets $Hx$ and $xH$ are known as the *right* and *left cosets* of the subgroup $H$ with element $x$. For this discussion, I need to concentrate on the collection left cosets for any element $x \in G$ defined as

$$
G/H = \big\lbrace xH | x \in G \big\rbrace \text{.}
$$

It is important to understand that $G/H$ is a set of left cosets. For a collection of elements $x_1,x_2,...,x_k \in G$ there is associated a collection of cosets $x_1H, x_2H,...,x_kH \in G/H$. The set (of cosets) $G/H$ is called homogeneous space.[^3] The next proposition shows that an action group can transform a coset into another coset within $G/H$.

{% include statement/proposition name="action on cosets"%}
Given a homogenous space $G/H$ of a group $G$ with a subgroup $H$, then there is a *transitive* action $(G/H, G, \mu)$ define by the function $\mu_g: G/H \rightarrow G/H; xH \mapsto gxH$ for each $g$ in $G$.[^4]
{% include statement/end %}

This proposition means that if we start from $x, y, g \in G$ such $y = gx$, then the coset $xH$ can be transformed to the coset $yH$ simply by the action $\mu_g(xH) = gxH = yH$. In words, all the cosets of a homogeneous space can be reached by transitive actions from any other coset.

Two extreme examples of homogenous spaces are significant. The homogeneous space $G/G$ (where the subgroup is $G$ itself) is *trivial*[^5] with *trivial action*[^6] $\mu_g(x) = x$. Alternatively, the homogeneous space $G/\lbrace e \rbrace$ (where $e$ is $G$ identity element) is *a simple representation* of $G$ because it is just to write every $x \in G$ as singleton set $\lbrace x \rbrace$[^7].

## Transitive actions are homogenous spaces

Let me summarize what I just described so far. First, I showed how to relate to different actions using *group-action homomorphism*. Second, I find that for a given subgroup $H$ of a group $G$, I can define a transitive action written exclusively as acting on cosets of $G/H$ **without referencing any other set!**

As a result, one can wonder if it might be possible to relate any transitive action on an arbitrary set to an action over a homogeneous space. The answer is yes, and it is a *central* theorem of action groups, and I will state it as follow.

{% include statement/theorem name="Transitive actions are homogeneous spaces" markdown="block"%}
Let $(X, G, \lambda)$ be a transitive action of a group $G$ on an nonempty set $X$. For each element $a$ of $X$, consider the stabilizer of $G_a$ under this action. Let $(G/G_a, G, \mu)$ be the homogeneous space action of $G$ on $G/G_a$. Then $X$ and $G/G_a$ are group-action isomorphic[^8]

$$
X \simeq G/G_a
$$

where the bijective function mapping both sets is $f: G/G_a \rightarrow X; gG_a \mapsto \lambda_g(a)$
{% include statement/end %}

Now for action group $(X, G, \lambda)$ and for each element $a$ of $X$ I can define the orbit $\lambda_G(a)$. I showed in a [early blog of this series]({% post_url 2022-04-04-tuning-systems %}) that by definition, the action of $G$ on elements of the orbit $\lambda_G(a)$ is transitive! Therefore, we have the following result.

{% include statement/corollary name="Orbits are isomorphic homogeneous spaces" markdown="block"%}
Let $(X, G, \lambda)$ be a transitive action of a group $G$ on an nonempty set $X$. For each element $a$ of $X$, consider  the orbit $\lambda_G(a)$ and the stabilizer of $G_a$ under this action. Then the orbit $\lambda_G(a)$ is group-action isomorphic to the homogeneous space $G/G_a$[^9]

$$
\lambda_G(a) \simeq G/G_a
$$
{% include statement/end %}

The following figure is a graphical representation of the theorem statement.

{% include image file="mt-action-group-fundamental-theom.svg" scale="90%" %}

This theorem also has a corollary to compute the size of $X$ in the case of a finite group $G$.

{% include statement/corollary %}
Let $(X, G, \lambda)$ action of a finite group $G$ on an nonempty set $X$. Then for each element $a$ of $X$, the orbit $\lambda\_G(a)$ is finite, with size $\vert \lambda\_G(a) \vert = \vert G \vert / \vert G\_a \vert$.
{% include statement/end %}

As you can see any action $\lambda_{G}$ with $g \in G_a$ leave the element $a \in X$ invariant or $\lambda_g(a) = a$. I interpret this by saying all the elements of of the subgroup $G_a$ are somewhat equivalent in the sense that the action group $(X, G, \lambda)$ transform $a$ into itself $a$. Now each coset $xG_a$ also produces another set of equivalent actions that takes $a$ into $\lambda_x(a)$. The process allows for creating group-action isomorphism between a homogeneous space and all points of action group orbit. Therefore, we can describe the set a group-action orbit by studying its related homogeneous space.

## Tuning systems are homogenous spaces

The application of these ideas to music is comes directly from my definition of tuning systems. This definition says tuning systems are action group orbits in the single pitch space.[^1] It follows then tuning systems are homogenous spaces.

{% include statement/corollary name="tuning systems are homogenous spaces" %}
Let $(\mathcal{S}, G, \lambda)$ be an action of a group $G$ on the single pitch space $\mathcal{S}$. Let $\mathcal{T}$ be the tuning system given by the orbit $\lambda_G(a)$ where $a \in \mathcal{S}$ is the standard pitch. It follows that the tuning system $\mathcal{T}$ is group-action isomorphic to the homogeneous space $G/G_a$
$$
\mathcal{T} \simeq G/G_a
$$
where we say in this case that $G/G_a$ is pitch class.
{% include statement/end %}

Arm with the corollary, we can now show some of the arguments done for the simple tuning systems defined in the [previous blog of this series]({% post_url 2022-05-16-simple-tuning-systems %}).

{% include statement/example name="positive-real tuning system is isomophic with positive real numbers" markdown="block"%}
Using the group action $(\mathcal{S}, G, \lambda)$ for $\mathcal{S} = \mathbb{R}$ and $G = (\mathbb{R}\_{>0}, \cdot, 1)$, I said that positive-real tuning system as the orbit $\mathcal{T} = \lambda_{\mathbb{R}\_{>0}}(1)$ where $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; x \mapsto gx$ for any $g \in G$. It is easy to see that the stabilizer around identity is the same as the identity itself $G_1 = \lbrace 1 \rbrace$. This means that $\mathcal{T} \simeq \mathbb{R}\_{>0}/\lbrace 1 \rbrace$ that is a simple representation of $\mathbb{R}\_{>0}$ in cosets $x\lbrace 1 \rbrace$ for $x \in \mathbb{R}\_{>0}$, or $\mathcal{T} \simeq \mathbb{R}\_{>0}$, and therefore its pitch class is $\mathbb{R}\_{>0}$.
{% include statement/end %}

The same argument applies to all the other simple tuning systems in the previous blog because their stabilizers contain only the identity element of their respectively groups.

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: [Blog about tuning systems]({% post_url 2022-04-04-tuning-systems %})
[^2]: Chap 1, page 5 of [^100]. In the book this function is known as *G-map* or *equivariant map*. However, I think a better terminology would be group actio (or action) homomorphism. This is more consistent with the Cathegory Theory approach of calling morphism to relationship between objects.
[^3]: Definition 10.20 of [^101].
[^4]: Proposition 10.19 of [^101].
[^5]: Example 10.8 of [^101].
[^6]: Chap 1, page 6 of [^101].
[^7]: Example 10.21 of [^101].
[^8]: Example 10.22 of [^101].
[^9]: Theorem 1.5 of [^100].
[^100]: Katsuo Kawakubo, The Theory of action Groups. Oxford University Press, 1991.
[^101]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
