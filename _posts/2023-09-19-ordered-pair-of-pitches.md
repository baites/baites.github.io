---
layout: post
title: Ordered pairs of pitches
date: 2023-09-19 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In this blog, I will explore ordered pairs of pitches (or simply pitch pairs) using the same techniques we applied to learn about single-pitch spaces. This post is my first step toward the main result summarized by the great book "A Geometry of Music." by Dmitri Tymoczko.[^1]

## Direct product of two groups

We build the concept of pitch class by using group actions on a single-pitch space name as a tuning system. Moreover, I show how the most helpful tuning system can be described using straightforward actions. Simple actions are defined using groups and homomorphism between those groups. The following proposition allows me to combine two groups to create a new group helpful to represent the pitch pairs.

{% include statement/proposition name="Direct product of two groups"%}
Let $(X, \circ_X, e_X)$ and $(Y, \circ_Y, e_Y)$ be groups. Then the direct product $X \times Y$ forms a group $(X \times Y, \circ_{X \times Y}, e_{X \times Y})$ under the componentwise multiplication, identity element, and inverses. [^2]
{% include statement/end %}

Using this proposition, we can combine any tuning system in this [summary]({% post_url 2023-04-24-tuning-system-summary %}) to represent two pitches.

## Combining two real tuning systems

### Approach

For example, combining two real tuning systems using their direct product and the appropriated componentwise operations and definitions is straightforward. All the concepts and theorems we define for single-pitch space follow trivially. As a result, the pitch class is $\cal{T} \simeq \mathbb{R}^2$. For completeness, I will define this group as a template for combining two common tuning systems.[^3] 

### Real-pitch pair tunning system 

Let pitch space $\mathcal{S}$ be the set of point in a two dimensional plane $\mathbb{R}^2$ and with function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{R}^2; p(f_1,f_2) = b_1\log_{a_1}(f_1/f_0) \mathbf{e}\_1 + b_2\log_{a_2}(f_2/f_0)\mathbf{e}\_2$ for some points $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such as the pitch $\mathbf{x} = (0,0)$ is the standard pitch of frequency $f_0$.[^4] Let me define the group action with group $(\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and a map $\lambda_{\mathbf{g}}: \mathbb{R}^2 \rightarrow \mathbb{R}^2; \lambda_{\mathbf{g}}(\mathbf{x}) = \mathbf{g + x}$ for any $\mathbf{g} \in \mathbb{R}^2$ with $\mathbf{+}$ componentwise operator and $\mathbf{0}$ representing the componentwise identity element $(0,0)$. The tuning systems pitch-class is the orbit $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0})$ that forms a **real pitch pair**.

Please observe that the stabilizer around identity is the same as the identity itself $G_\mathbf{0} = \lbrace \mathbf{0} \rbrace$. It follows then $\lambda_{\mathbb{R}^2}(\mathbf{0})$ is group-action isomorphic to homogenous space $\mathbb{R}^2/ \lbrace \mathbf{0} \rbrace$ that is a simple representation of $\mathbb{R}^2$. This means that the pitch-class $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0}) \simeq \mathbb{R}^2$.[^5]

Therefore, we can represent this tuning system as a two-dimensional plane where each point parametrized the action from the standard to an arbitrary pitch pair. Alternatively, we could use the pitch space $\cal{S}$ itself because for this tuning system has no practical differences. However, understanding pitch class algebra or geometry will become more relevant as we apply less trivial actions over the standard pitch pair. 

### Ploting real-pitch pair tuning system

In the following plot, we show as an example a representation of the real pitch pair with action given by coordinates $A = (0.25, 0.75)$. As a result of the action, we transform the standard pitch from $(0,0)$ to $(0.25,0.75)$ within $\cal{S}$. Moreover, if I choose the pitch-space function to be $p(f_1,f_2) = \log_{2}(f_1/f_0) \mathbf{e}\_1 + \log_{2}(f_2/f_0)\mathbf{e}\_2$, then following frequency values $f_1 = 2^{0.25}f_0$ and $f_2 = 2^{0.75}f_0$ are associated to that pitch pair or $p(f_1,f_2) = (0.25, 0.75)$.

{% include image file="real-pitch-pair.svg" scale="80%" %}

## Octave-equivalent real-pitch pair

### Tunning system 

Next we would like to find a octave-equivalent version for the real pitch pair. Using the same approach as above we derive the following definition.

Let pitch space $\mathcal{S}$ be the set of two dimensional complex numbers $\mathbb{C}^2$ and with function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{C}^2; p(f\_1,f\_2) = e^{i2\pi b\_1\log\_{a\_1}(f_1/f_0)} \mathbf{e}\_1 + e^{i2\pi b\_2\log\_{a\_2}(f\_2/f\_0)}\mathbf{e}\_2$ for some points $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such as the pitch $\mathbf{x} = \mathbf{1} = (1,1)$ is the standard pitch of frequency $f_0$.[^4] Let me define the group action with group $(\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and a map $\lambda_{\mathbf{g}}: \mathbb{C}^2 \rightarrow \mathbb{C}^2; \lambda_{\mathbf{g}}(\mathbf{x}) = e^{i2\pi g_1} x_1 \mathbf{e}\_1 + e^{i2\pi g_2} x_2 \mathbf{e}\_2$ for any $\mathbf{g} \in \mathbb{R}^2$ with $\mathbf{+}$ componentwise operator and $\mathbf{0}$ representing the componentwise identity element $(0,0)$. The tuning systems pitch-class is the orbit $\mathcal{T} = \lambda_{\mathbb{R}^2}\left(\mathbf{1}\right)$ that forms a **octave-equivalent real pitch pair**.

The tuning system is just the direct product of two octave-equivalent real tuning systems[^6] in where the pitch class is $\mathbb{R}/\mathbb{Z}$ isomorphic with group circle $\mathbb{T}$. As result the pitch class of a octave-equivalent real pitch pair is simply $\mathbb{T}^2$.

### Octave-equivalent real-pitch pair is a Torus

One way to visualize this tuning system is by representing the pitch space as a pair of to unit circles. Technically, those circules are the unit circule in complex plan $\mathbb{C}$. An arrow from their center represent any point of those circles circunferences. An action given by coordinates $A = (0.25, 0.75)$ transforms the standard pitch $(1,1)$ into to $(e^{i\pi/2},e^{i3\pi/2})$, see figure below. Assuming a pitch-space function given by $p(f\_1,f\_2) = e^{i2\pi \log\_2(f_1/f_0)} \mathbf{e}\_1 + e^{i2\pi \log\_2(f\_2/f\_0)}\mathbf{e}\_2$, then the collection of frequency $f_1 = 2^{0.25+n}f_0$ and $f_2 = 2^{0.75+n}f_0$ for $n \in \mathbb{Z}$ are related to pitch pair because $p(f_1,f_2) = (e^{i\pi/2},e^{i3\pi/2})$.

{% include image file="octave-equivalent-real-pitch-pair-transform.svg" %}

Alternative we can avoid thinking on the action over the pitch space and represent each pitch pairs as elements on pitch-class $\mathbb{T}^2$, meaning the homogeneous spaces that group-action isomorphic tuning system[^5]. The direct product of the group circle $\mathbb{T}^2$ is isomorphic to the shape a of a Torus embedded in a 3D space under the transformation

$$
\begin{cases}
X(g_1,g_2) = \left[R + r \cos(g_1)\right] \cos(g_2) \\
Y(g_1,g_2) = \left[R + r \cos(g_1)\right] \sin(g_2) \\
Z(g_1,g_2) = r \sin(g_1)
\end{cases}
$$

where the major radius $R$ is the distance from the center of the tube to the center of the torus and the minor radius $r$ is the radius of the tube under the condition $0 < r < R$[^7]. This means action given by coordinates $(0.25, 0.75)$ can be represented as points in the surface of a torus as shown the figure below.

{% include image file="embedded-torus.svg" scale="80%" %}

{% include image file="octave-equivalent-real-pitch-pair.svg" scale="80%" %}

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: Tymoczko, Dmitri. A geometry of music: Harmony and counterpoint in the extended common practice. Oxford University Press, 2010.
[^2]: Proposition 4.30 of [^100].
[^3]: [Tuning system summary]({% post_url 2023-04-24-tuning-system-summary %}) 
[^4]: I am using the notation for standard notation where $\mathbf{e}_1 = (1,0)$ and $\mathbf{e}_2 = (0,1)$, and bold to represent ordered pairs of elements.
[^5]: See for details [Tuning systems are homogeous spaces]({% post_url 2022-07-25-tuning-systems-are-homogeneous-spaces %})
[^6]: [Tuning systems with equivalence of the octaves]({% post_url 2023-02-05-tuning-systems-w-equivalence-of-the-octaves %})
[^7]: [Wikipedie entry for Torus.](https://en.wikipedia.org/wiki/Torus)
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
