---
layout: post
title: "Xmas blog: Tuning systems by simple actions"
date: 2022-12-26 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In the previous blog of this series[^1], I showed that building tuning systems as orbit of a group action given by $G$ over a single pitch space $\mathcal{S}$ from standard pitch $a$ has an equivalent counterpart as an action in homogenous spaces $G/G_a$. Both sets of actions are related by group-action isomorphism. The advangate of actions over homogenous spaces is that they can be defined almost exclusively using elements of the group $G$. However, this approach still depends in principle on the value of standard pitch $a$.

For most application in music like defining scales, it will be important for tuning systems to be invariant to the choice of standard pitch. In this blog I will show how to create tuning systems with this property. In the process of defining this tuning systems I will rely on another famous abstract algebra theorem: the First Isomorphism Theorem for Groups.

## Pitch space as a group and simple actions

I start by enhancing the defition of simple pitch space[^2] by assuming it is also a group $(\mathcal{S}, \cdot, e')$.[^3] Using the added structure I write $\lambda_g(x)$ as the action given by

$$
\lambda_g(x): \mathcal{S} \rightarrow \mathcal{S}; x \mapsto \phi(g) \cdot x
$$

where $\phi: G \rightarrow \mathcal{S}$ is a function relating elements of the groups $G$ and $\mathcal{S}$. I refer to the actions as defined above as **simple actions**.

Group-action composition says that $\lambda_{gh}(x) = \lambda_g(\lambda_h(x))$ for all $g, h \in G$ and $x \in X$. It follows then

$$
\begin{align*}
  \lambda_{gh}(x) &= \lambda_g(\lambda_h(x)) \\
  \phi(gh) \cdot x &= \phi(g) \cdot (\phi(h) \cdot x) \\
  \phi(gh) \cdot x &= (\phi(g)\phi(h)) \cdot x \\
\end{align*}
$$

The last equality is possible if and only if 

$$\phi(gh) = \phi(g)\phi(h).$$

Group actions also require that $\lambda_e(x) = x$ or $\phi(e)x = x$ that implies by right multiplication by $x^{-1}$ that

$$\phi(e) = e'$$

Lastly, if $g = h^{-1}$ that is the inverse of $h \in G$, then $e = \phi(e) = \phi(h^{-1}h) = \phi(h^{-1}) \phi(h)$ implying that 

$$\phi(h^{-1}) = \phi(h)^{-1}.$$

The function $\phi: G \rightarrow \mathcal{S}$ that complies with all these properties is know as a **group homomorphism**[^4]. Furthermore, you get a **group isomorphism** if a group homomorphic function is also bijective.

## Tuning systems of simple acctions

I define a tuning system $\cal{T}$ by group action orbits $\lambda_G(a)$ for a given standard pitch $a$. I pointed out that a fundamental property of group-action orbit is that they are homogeneous spaces $\lambda_G(a) \simeq G/G_a$ where $G_a$ is the group action stabilizer.[^5] Just as reminder, the group action estibilizer $G_a$ are all the group action that transform $a$ element in to itself:

$$G_a = \lbrace g \in G: \lambda_g(a) = a\rbrace.$$

In case of a simple group actions, all elements on $g \in G$ such as $\lambda_g(a) = \phi(g) \cdot a = a$ are those elements $g$ in $G$ so $\phi(g) = e$ where $e$ is the identity of $G$. In other words, $G_a = \text{Ker}_{\phi}$ where $\text{Ker}\_{\phi}$ is known as the kernel of the homorphism $\phi$ and it is given by

$$\text{Ker}_{\phi} = \lbrace g \in G: \phi(g) = e\rbrace = \phi^{-1}(e)$$

resulting in the following lemma.

{% include statement/lemma name="pitch class for simple-action tuning system" %}
Let $(\mathcal{S}, G, \lambda)$ be an action of a group $G$ on the single pitch space group $\mathcal{S}$, with a simple action $\lambda_g(x): G \rightarrow X; x \mapsto \phi(g) \cdot x$ for a group homomorphism $\phi: G \rightarrow \mathcal{S}$. Let $\mathcal{T}$ be the tuning system given by the orbit $\lambda_G(a)$ where $a \in \mathcal{S}$ is the standard pitch. It follows that the tuning system $\mathcal{T}$ is group action isomorphic to the homogeneous space $G/\text{Ker}\_{\phi}$
$$
\mathcal{T} \simeq G/\text{Ker}_{\phi}
$$
and therefore $G/\text{Ker}\_{\phi}$ its pitch class, and it is independent of the standard pitch of choice.
{% include statement/end %}

There is even more. The orbit $\lambda_G(a)$ is group-action isomorphic to $G/\text{Ker}\_{\phi}$ by bijective function $f:G/\text{Ker}\_{\phi} \rightarrow \lambda\_G(a); g\text{Ker}\_{\phi} \mapsto \phi(g) \cdot a$.[^6] This function can be writen as the composition $f = f'' \circ f'$ where $f': G/\text{Ker}\_{\phi} \rightarrow \phi(G); g\text{Ker}_{\phi} \mapsto \phi(g)$ and $f'': \phi(G) \rightarrow \lambda\_G(a); g \mapsto g \cdot a$. Therefore the composition implies that the homormorphism $f'$ (because $\phi$ is homomorphic) is also bijective resulting in the fact that $G/\text{Ker}\_{\phi}$ is group isomorphic with $\phi(G)$ also notated as $G/\text{Ker}\_{\phi} \simeq \phi(G)$ (see diagram below).[^7]

{% include image file="mt-group-fundamental-theom.svg" scale="90%" %}

In summary, the fact that tuning systems are homogenous spaces when apply to simple group actions reduces to what is know as the **First Isomorphism Theorem for Groups**.[^8]

{% include statement/theorem name="First Isomorphism Theorem for Groups" markdown="block" %}
Let $\phi: X \rightarrow Y$ be a group homormorphism between two groups $X$ and $Y$ with identity elements $e_x$ and $e_y$, respectively. The function $\phi$ can be factorized as

$$\phi = j \circ b \circ s$$

where the surjection $s$ may be taken as the surjective homomorphism

$$s: X \rightarrow X/\text{Ker}_{\phi}; x \mapsto x\text{Ker}_{\phi}$$

the bijection $b$ is the well-defined group isomorphism

$$b: X/\text{Ker}_{\phi} \rightarrow \phi(X); x\text{Ker}_{\phi} \mapsto \phi(x)$$

from the quotient $X/\text{Ker}\_{\phi}$ (defined here as the left cosets of $\text{Ker}\_{\phi}$) to the image $\phi(x)$, and the injection $j$ is the injective group homormophism

$$j: \phi(X) \rightarrow Y; \phi(x) \mapsto \phi(x)$$

This is usually represented by the following graph:

$$
\begin{CD}
   X @>\phi>> Y \\
@VsVV @AAiA \\
   X/Ker_{\phi} @>>b> \phi(X)
   \end{CD}
$$

{% include statement/end %}

I more detailed explanation of the theorem and other important concept such normal subgroup, quotient group, etc is outside of the scope of this blog. For an intuitively explenation of the theorem and associated concepts can be found [^9]. All the details can be read at Smith's wonderful book[^100].

The First Isomorphism Theorem for Groups provides as corollary that allows compute the size of the image $\phi(X)$ in case $X$ is finite.

{% include statement/corollary markdown="block" %}
Let $\phi: X \rightarrow Y$ be a group homomorphism with kernel $\text{Ker}_\phi$ and finite domain $X$. The the size $\vert \phi(X) \vert$ of the image of $\phi$ is the index

$$|X/\text{Ker}_\phi| = \vert X \vert / \vert \text{Ker}_\phi \vert$$

of the subgroup $\text{Ker}\_\phi$ of $X$.
{% include statement/end %}

In the context of tuning systems the theorem says that $\phi$ divides the group $G$ in set of equivalent elements. Those *equivalent* elements are mapped by $\phi$ to individual elements of $\mathcal{S}$. For finite group $G$, the previous corollary implies that the size of a tuning system $\vert \mathcal{T} \vert = \vert G \vert / \vert \text{Ker}_\phi \vert$.

## Simple tuning systems are simple actions

For all all the simple tuning systems it is not hard to show that are simple actions with $\text{Ker}_{\phi} = \lbrace e \rbrace$ for all of them.[^10]

{% include statement/example name="positive-real tuning system is isomorphic with positive real numbers" markdown="block"%}
With group action $(\mathbb{R}\_{>0}, \cdot, 1)$ I defined positive-real tuning system as the orbit $\mathcal{T} = \lambda_{\mathbb{R}\_{>0}}(1)$ where $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}; x \mapsto gx$ for any $g \in \mathbb{R}\_{>0}$. It is easy to see that the action is a simple action with $\phi: \mathbb{R}\_{>0} \rightarrow \mathbb{R}; g \mapsto g$. It easy to see that the group kernel is $\text{Ker}_{\phi} = \lbrace 1 \rbrace$. Therefore, we get the trivial statement that the pitch class is isomorphic to all positive reals ${R}\_{>0}/\lbrace 1 \rbrace \simeq {R}\_{>0}$.
{% include statement/end %}

You can do the same argument to conclude that for

* real tuning system $\phi: \mathbb{R} \rightarrow \mathbb{R}; g \mapsto g$, resulting in pitch class is $\mathbb{R}$,
* equal temperament tuning system $\phi: \mathbb{Z} \rightarrow \mathbb{Z}; g \mapsto g$, and then pitch class is $\mathbb{Z}$,
* $p_n$-limit tuning system $\phi: \mathbb{Z}^n \rightarrow \mathbb{Q}; g \mapsto \prod^n\_{i=1} p^{g\_i}\_i$ so the pitch class is $\mathbb{Z}^n$.

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: [Blog about tuning systems]({% post_url 2022-04-04-tuning-systems %})
[^2]: [Simple pitch space]({% post_url 2022-02-21-single-pitch-space %})
[^3]: Definition 4.14 of [^100]. I also discuss the concept in the blog [Group actions and tuning systems]({% post_url 2022-04-04-tuning-systems %}#groups)
[^4]: Definition 5.1 of [^100].
[^5]: corollary: Orbits are isomorphic homogeneous spaces.[^101]
[^6]: Theorem: Transitive actions are homogeneous spaces, see by the end of the theorem statement.
[^7]: I am reusing the notation $\simeq$ for group or group-action isomophisms.
[^8]: This is based the Theorem 5.21 of [^100]. Be aware that I took some *artistic lisences* relative to the full version in the book. Alternative references about the theorem are the [WolframMathWorld entry](https://mathworld.wolfram.com/FirstGroupIsomorphismTheorem.html) or [Wiki entry](https://en.wikipedia.org/wiki/Fundamental_theorem_on_homomorphisms).
[^9]: [The First Isomorphism Theorem, Intuitively](https://www.math3ma.com/blog/the-first-isomorphism-theorem-intuitively)
[^10]: Example section.[^101] All these tuning system are introduced in [Simple runing systems]({% post_url 2022-05-16-simple-tuning-systems %})

[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.


[^101]: [Tuning systems are homogeneous spaces]({% post_url 2022-07-25-tuning-systems-are-homogeneous-spaces %})

