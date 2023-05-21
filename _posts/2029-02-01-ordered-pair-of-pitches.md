---
layout: post
title: Ordered pairs of pitches
date: 2029-02-01 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Ordered

In this blog, I will explore ordered pair of pitches (or simply pitch pairs) using the same techniques we apply to learn about single-pitch spaces. This is my first step toward recovering the main result summarized by the great book by Dmitri Tymoczko's "A geometry of music".[^1]

## Direct product of two groups

We build the concept of pitch class by using group actions on a single-pitch space name as a tuning systems. Moreover, I show how the most helpful tuning system can be described using simple actions. Simple actions are defined using groups and homomorphism between those groups. The following proposition allows me to combine two groups to create a new group helpful to represent the pitch pairs.

{% include statement/proposition name="Direct product of two groups"%}
Let $(X, \circ_X, e_X)$ and $(Y, \circ_Y, e_Y)$ be groups. Then the direct product $X \times Y$ forms a group $(X \times Y, \circ_{X \times Y}, e_{X \times Y})$ under the componentwise multiplication, identity element, and inverses. [^2]
{% include statement/end %}

Using this proposition we can combined any tuning system in this [summary]({% post_url 2023-04-24-tuning-system-summary %}) to represent two pitches.

## Combining two real tuning system

As example it is straight foward to combined two real tuning systems using their direct product and the appropiated componentwise operations and definitions. All the concepts and theorems we define for single-pitch space trivially follows. As a result the pitch class is simply $\cal{T} \simeq \mathbb{R}^2$.

For completness, I will define in detail this group as template touse in any other two of the common tuning systems.[^3] Let $\mathcal{S}$ be the set of point in a two dimensional plane $\mathbb{R}^2$ and with function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{R}^2; p(f_1,f_2) = b_1\log_{a_1}(f_1/f_0) \mathbf{e}\_1 + b_2\log_{a_2}(f_2/f_0)\mathbf{e}\_2$ for some points $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such as the pitch $\mathbf{x} = (0,0)$ is the standard pitch of frequency $f_0$.[^4] Let me define the group action with group $(\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and a map $\lambda_{\mathbf{g}}: \mathbb{R}^2 \rightarrow \mathbb{R}^2; \lambda_{\mathbf{g}}(\mathbf{x}) = \mathbf{g + x}$ for any $\mathbf{g} \in \mathbb{R}^2$ with $\mathbf{+}$ componentwise operator and $\mathbf{0}$ representing the componentwise identity element $(0,0)$. The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0})$ that forms a real pitch pair.

Observe that the stabilizer around identity is the same as the identity itself $G_\mathbf{0} = \lbrace \mathbf{0} \rbrace$. It follows then $\lambda_{\mathbb{R}^2}(\mathbf{0})$ is group-action isomorphic to homogenous space $\mathbb{R}^2/ \lbrace \mathbf{0} \rbrace$ that is a simple representation of $\mathbb{R}^2$ or $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0}) \simeq \mathbb{R}^2$.[^5]

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
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
