---
layout: post
title: An algebra for orbichords II (Fundamental actions are equivalent spaces)
date: 2029-01-14 18:00:00 -0400
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

## Action over equivalence spaces

I start this blog establishing defining actions in the equivalent space. As in the case of homogenous spaces, it is not only thier element, but the action you can take withing those spaces and how they map as action over more generic set $X$.[^1] 

{% include statement/definition name="Action on equivalent spaces" markdown="block" %}
Given an fundamental action $(X, G, \lambda)$ with equivalent space $G/E_a$, the monion action $(G/E_a, G, \mu)$ with $\mu_g: G/E_a \rightarrow G/E_a$ defined as

$$ E[h, a] \mapsto E[g\pi_a(h), a] $$

for $g,h \in G$, $a \in X$ and $\pi_a$ is the fundamental domain map of $(X, G, \lambda)$.
{% include statement/end %}

{% include statement/remark name="About notation" markdown="block" %}

For funamental action $(X, G, \lambda)$, any element of $X$ is designated in lower case, for example $a \in X$. The set of equivalent actions $E_{\lambda}[h,a]$ is simply $E[h,a]$.

I use uppercase for elements of the action equivalence space or $A \in G/E_a$. Moreover, for monion action $(G/E_a, G, \mu)$, the set of equivalent actions $E_{\mu}[h,A]$ is simply $E[h,A]$, using uppercase convention for elements of $G/E_a$ to distinguish between action equivalence spaces. Tha same applies for its fundamental domain $D_A$ and map $\pi_A: G \rightarrow D_A$.
{% include statement/end %}

Please notice actions over equivalent spaces is a relative definition as they depend on properties of the action establishing the equivalence. As result we have the following property. For element $A \in G/E_a$ that is set of equivalent actions under identity action over $a \in X$ or $A = E[e,a]$ then

$$ 
\begin{aligned}
E_{\mu}[h,A] &= \left\{g \in G \text{ | } \mu_g(A) = \mu_h(A) \right\} \\
             &= \left\{g \in G \text{ | } E_{\lambda}[g,a] = E_{\lambda}[h,a]\right\} \\
             &= \left\{g \in G \text{ | } \lambda_g(a) = \lambda_h(a)\right\} \\
             &= E_{\lambda}[h,a] 
\end{aligned}
$$

where the last equality is because there is no overlap between images and it is enough they share one element of each equivalent set.

{% include statement/lemma name="Action on equivalent spaces are fundamental" markdown="block" %}
The monion action over an equivalent space $(G/E_a, G, \mu)$ as define above is a fundamental action!
{% include statement/end %}

From above in case, we show that for $A = E[e,a]$, the set of equivalent actions over equivalence space $E_{\mu}[h,A] = E_{\lambda}[h,a]$. But then it follows that both action share the same funamental domain $D_A = D_a$ and map $\pi_A = \pi_a$!

$$ 
\begin{aligned}
\mu_g \circ \mu_h(A) &= \mu_g\left(E[h,a]\right) \\
             &= E[g\pi_a(h), a] = E[g\pi_A(h), a] \\
             &= \mu_{g\pi_A(h)}(A)
\end{aligned}
$$

Therefore, acctions over the equivalent space are the generalization of those in homogeneous spaces. As in the case of homogenous spaces, we are looking to transfer the same composition rule of action on equivalent spaces define by action and elements on $G$ over actions on $X$. 

## Fundamental-action holomorphism

So first, we need to extend what I mean with transfer the property of fundamental between action in two sets.

{% include statement/definition name="Fundamental-action holomorphism" markdown="block" %}
Given two fundamental actions $(X, G, \mu)$ and $(Y, G, \lambda)$ with a common group $G$, a function $f: X \rightarrow Y$ is a fundamental-action homomorphism if following the relation holds for any $g \in G$ and $x \in D_a$ the fundamental domain

$$f \circ \mu_g(x) = \lambda_g \circ f(x) $$
{% include statement/end %}

The homomorphism relates both actions so for any element $x \in X$ there is an element $y \in Y$ so $y = f(x)$. Assume now that a fundamental action on $x \in X$ resulting in $x^{\prime} = \mu_g(x)$ and also on $y \in Y$ resulting in $y^{\prime} = \lambda_g(y)$ for any $g \in G$. If $f$ is a fundamental-action homomorphism, then it also true that $y^{\prime} = f(x^{\prime})$. In a way, the homomorphism $f$ relates the results of both actions under the same group.

This is a generalization of the notion of group-action homormorphism we discussed in previous post[^4]. However, there is an important limitation as a result. The relationship in the applies only to **<u>some</u>** element of $x \in X$ instead for all elements as in case group-action homormorphism. We will see elements of $X$ might not be reachable by fundamental actions depending its definition and fundamental domain. Naturaly we can also define the case for isomorphisms between fundamental action groups.

{% include statement/definition name="fundamental-action isomorphism"%}
Given two action groups $(X, G, \lambda)$ and $(Y, G, \mu)$ with a common group $G$, a fundamental-action homomorphism $f: X \rightarrow Y$, that is also bijective, is called a fundamental-action isomorphism between the set $X$ and $Y$. In this case, we say that $X$ and $Y$ are isomorphic using the notation $X \simeq Y$.
{% include statement/end %}

## Equivalent space 

{% include statement/theorem name="Fundamental actions are equivalent spaces" markdown="block" %}
Let a fundamental-action $(X, G, \lambda)$ of $G$ on non-empty $X$. For some element $a \in X$, consider the equivalent space $G/E_a$ and fundamental action $(G/E_a, G, \mu)$ of $G$ on $G/E_a$. Then the function $f:G/E_a \rightarrow \lambda_G(a); E[h,a] \mapsto \lambda_h(a)$ is a fundamental action isomophism or

$$ G/E_a \simeq \lambda_G(a) $$
{% include statement/end %}

**Proof:** We start in the theorem *monion actions are equivalent spaces* I showed that $f:G/E_a \rightarrow \lambda_G(a)$ is a bijection. Now we can also show $f$ is a fundamental-action homomorphism. It follows directly from definition on action and its compostion rule that

$$
\begin{aligned}
f \circ \mu_g\left(E[h,a]\right) &= f\left(E[g\pi_a(h),a]\right) \\
                                 &= \lambda_{g\pi_a(h)}(a) = \lambda_g \circ \lambda_h(a) \\
                                 &= \lambda_g f\left(E[h,a]\right).
\end{aligned}
$$

where equality is because $f$ is bijective. Therefore, $f$ is therefore a fundamental-action isomorphism.$\square$

## Orbichords are equivalent spaces

The application to music is comes directly by redefining the notions of tuning system to cover also orbichords. 

{% include statement/definition name="Extended tuning system" %}
Let $(\mathcal{S}, G, \lambda)$ be a fundamental-group action of a group $G$ on the pitch space $\mathcal{S}$ with fundamental domain $D_a$ relative to $a \in \mathcal{S}$. I say that the tuning system notated $\mathcal{T}$ is the orbit $\lambda_G(a)$ and that $a$ is its standard pitch.
{% include statement/end %}

{% include statement/remark name="Key difference with definition based on action groups" markdown="block" %}
* The definition applies for any finite dimension.
* Fundamental-group action can include any type of equivalences no only those given by stebilizer $G_a$.
* The standard pitch $a \in \mathcal{S}$ plays a more central role the generator of the fundamental domain $D_a$!
{% include statement/end %}

It follows then extended tuning systems are fundamental-group isomorphic to equivalent spaces.

{% include statement/corollary name="extended tuning systems are equivalent spaces" %}
Let $(\mathcal{S}, G, \lambda)$ be a fundamental-group action of $G$ on pitch space $\mathcal{S}$. Let $\mathcal{T}$ be the tuning system given by the orbit $\lambda_G(a)$ where $a \in \mathcal{S}$ is the standard pitch. It follows that the extended tuning system $\mathcal{T}$ is fundamental-group isomorphic to the equivalent space $G/E_a$
$$
\mathcal{T} \simeq G/E_a
$$
where we say in this case that $G/E_a$ is pitch class.
{% include statement/end %}

This means that any interested Orbichord in $\mathcal{S}$ can be studies by a extended tuning system $\mathcal{T}_a$. Any group product in the equivalent space $G/E_a$ result in composition of actions on $\mathcal{S}$.

{% include image file="mt-fundamental-action-theom.svg" scale="90%" %}

## Interpretation

Fundamental actions allow us to think group actions in two fundamental ways. We can think as group actions restricted to a fundamental domain $D_a$ relative to $a \in \mathcal{S}$. Each element of that domain result in a unique action over $a$. We can use the group product for composing these actions as long we reduce map first any element $g \in G$ to the fundamental domain $\pi_a(g)$. This is the prefer choice argued by Tymoczko.[^200] 

Alternative, we can think these actions as transformations between set of equivalent actions on $a$. The fact fundamental actions are equivalent spaces means these two approaches are equivalent or fundamental-action ismorphic.

{% include image file="mt-fundamental-action-isomorphism.svg" scale="90%" %}

## References

[^1]: Eventually $X$ action over space of tuple of pithes when aply to music.
[^2]: Definition 3.2 of [^100].
[^3]: [A pair of pitches with a twist]({% post_url 2025-12-10-a-pair-of-pitches-with-a-twist %})
[^4]: [Tuning systems are homogeous spaces]({% post_url 2022-07-25-tuning-systems-are-homogeneous-spaces %})
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
[^200]: Tymoczko, Dmitri. A geometry of music: Harmony and counterpoint in the extended common practice. Oxford University Press, 2010.
