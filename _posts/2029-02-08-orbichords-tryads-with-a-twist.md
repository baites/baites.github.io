---
layout: post
title: Music dyads with a twist (2-orbichords)
date: 2029-02-08 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Music dyads

Music dyads are sets of two notes or pitches. In this blog, I will explore what we can learn about the properties of dyads using the same techniques we apply to learn about single-pitch spaces. The goal is to recover the main result summarized by the great Dmitri  Tymoczko's "A geometry of music".[^1]


Let $\mathcal{S}$ be the set of point in a two dimensional plane $\mathbb{R}^2$ and with function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{R}^2; p(\mathbf{f}) = b_1\log_{a_1}[f_1/f_0] \mathbf{e}\_1 + b_2\log_{a_2}[f_2/f_0]\mathbf{e}\_2$ for some points $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such as the pitch $\mathbf{x} = (0,0)$ is the standard pitch of frequency $f_0$.[^3] Let me define the group action with group $(\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and a map $\lambda_{\mathbf{g}}: \mathbb{R}^2 \rightarrow \mathbb{R}^2; \lambda_{\mathbf{g}}(\mathbf{x}) = (g_1 + g_2) x_1 \mathbf{e}\_1 + \vert g_2 - g_1 \vert x_2 \mathbf{e}\_2$ for any $\mathbf{g} \in \mathbb{R}^2$ with $\mathbf{+}$ componentwise operator and $\mathbf{0}$ representing the componentwise identity element $(0,0)$. The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0}) \simeq \mathbb{R}^2$ that forms a real dyad.

## Octave

Let $\mathcal{S}$ be the set of point in a two dimensional plane $\mathbb{R}^2$ and with function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{R}^2; p(\mathbf{f}) = b_1\log_{a_1}[f_1/f_0] \mathbf{e}\_1 + b_2\log_{a_2}[f_2/f_0]\mathbf{e}\_2$ for some points $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such as the pitch $\mathbf{x} = (0,0)$ is the standard pitch of frequency $f_0$.[^3] Let me define the group action with group $(\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and a map $\lambda_{\mathbf{g}}: \mathbb{R}^2 \rightarrow \mathbb{R}^2; \lambda_{\mathbf{g}}(\mathbf{x}) = e^{i2\pi(g_1 + g_2)} x_1 \mathbf{e}\_1 + e^{i2\pi\vert g_2 - g_1 \vert} x_2 \mathbf{e}\_2$ for any $\mathbf{g} \in \mathbb{R}^2$ with $\mathbf{+}$ componentwise operator and $\mathbf{0}$ representing the componentwise identity element $(0,0)$. 

The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}^2}(\mathbf{0}) \simeq (\mathbb{R}/\mathbb{Z})^2/S_2 \simeq \mathbb{T}^2/S_2$ 

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: Tymoczko, Dmitri. A geometry of music: Harmony and counterpoint in the extended common practice. Oxford University Press, 2010.
[^2]: Proposition 4.30 of [^100].
[^3]: I am using the notation for standard notation where $\mathbf{e}_1 = (1,0)$ and $\mathbf{e}_2 = (0,1)$, and bold to represent ordered pairs of elements.
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
