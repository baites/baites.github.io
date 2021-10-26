---
layout: post
title: Tuning systems with equivalence of the octaves
date: 2029-02-07 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

## Adding quivalence of the octaves

### Positive-real octave-equivalent tuning system

Let $\mathcal{S}$ be the set of complex numbers $\mathbb{C}$ and the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi\log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}\_{>0}, \cdot, 1)$ and map $\lambda_g: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto e^{i2\pi\log_2(x)}z$ for any $x \in \mathbb{R}\_{>0}$. The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}\_{>0}}(1)$ and I call it **positive-real octave-equivalent tuning system**.

The reason of why this convey the notion of octive equivalence is the stabilizer of this group action for the standard pitch is given by all the sets $x \in \mathbb{R}\_{>0}$ such $e^{i2\pi\log_2(x)} = 1$, meaning $x = 2^n$ for $n \in \mathbb{Z}$ also known as the set $2^{\mathbb{Z}}$. Therefore, because tuning systems are homogenous spaces I get that the pitch class of this tuning system is then $\mathbb{R}\_{>0}/2^{\mathbb{Z}}$. It is known that $\mathbb{R}\_{>0}/2^{\mathbb{Z}}$ is group isomorphic to the circule group $\mathbb{T}$.

## References

[^1]: [Blog about tuning systems]({% post_url 2029-02-03-tuning-systems %})
