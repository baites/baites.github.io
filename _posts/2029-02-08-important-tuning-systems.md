---
layout: post
title: Important tuning systems
date: 2029-02-08 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In this blog I summarize all the tuning systems discussed so far, see table below. I think cover all of practical importance and beyond. The symbols in the table are defined next.

| Symbol         | Description                      |
|----------------|----------------------------------|
| $\mathcal{S}$  | Single pitch space[^1]           |
| $p(f)$         | Frequency-to-pitch mapping[^1]   |
| $G$            | Group of the Group Action[^2]    |
| $\lambda_g(x)$ | Function of the Group Action[^2] |
| $F$            | Set of pitch's frequencies       |
| $\mathcal{T}$  | Pitch class[^2]                  |


## Tuning system table

| Tuning system           | $\mathcal{S}$        | $p(f)$            | $G$                            | $\lambda_g(x)$                 | $F$                                                   | $\mathcal{T}$         |
|-------------------------|----------------------|-------------------|------------------------------------|--------------------------------|-------------------------------------------------------|------------------------------------------------|
| Positive-real[^3]        | $\mathbb{R}$        | $f/f_0$           | $(\mathbb{R}\_{>0}, \cdot, 1)$     | $gx$                           | $\mathbb{R}\_{>0}$                                    | $\mathbb{R}\_{>0}$ or $\mathbb{R}$[^4]         |
| Real[^3]                | $\mathbb{R}$         | $b\log_a(f/f_0)$  | $(\mathbb{R}, +, 0)$               | $g+x$                          | $\mathbb{R}\_{>0}$                                    | $\mathbb{R}$ or $\mathbb{R}\_{>0}$[^4]         |
| Equal ratio[^3]         | $\mathbb{R}$         | $f/f_0$           | $(a^{\mathbb{Z}b^{-1}}, \cdot, 1)$ | $gx$                           | $a^{\mathbb{Z}b^{-1}} f_0$                                | $a^{\mathbb{Z}b^{-1}}$ or $\mathbb{Z}$[^4] |
| Equal temperament[^3]   | $\mathbb{R}$         | $b\log_a(f/f_0)$  | $(\mathbb{Z}, +, 0)$               | $g+x$                          | $a^{\mathbb{Z}b^{-1}} f_0$                                | $\mathbb{Z}$ or $a^{\mathbb{Z}b^{-1}}$[^4] |
| $p_n$-limit[^3]         | $\mathbb{R}$         | $f/f_0$           | $(\mathbb{Z}^n, +, 0)$             | $\prod^n\_{i=1} p^{g\_i}\_i x$ | $\prod^n\_{i=1} p^{g\_i}\_i f_0$ $g \in \mathbb{Z}^n$ | $\mathbb{Z}^n$        |
| Octave-equivalent positive-real[^5]     | $\mathbb{C}$       | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{R}\_{>0}, \cdot, 1)$ | $e^{i2\pi\log_2(g)} x$         | $\mathbb{R}\_{>0}$                                    | $\mathbb{T}$ |
| Octave-equivalent real[^5]              | $\mathbb{C}$       | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{R}, +, 0)$           | $e^{i2\pi g} x$                | $\mathbb{R}\_{>0}$                                    | $\mathbb{T}$ |
| n-equal tone ration[^5]      | $\mathbb{C}$  | $e^{i2\pi f/f_0}$  | $(2^{\mathbb{Z}/n}, \cdot, 1)$ | $e^{i2\pi n\log_2(g)} x$ | $2^{\mathbb{Z}/n} f_0$ | $U_n$ $\mathbb{Z}/n{\mathbb{Z}}$ $\mathbb{Z}_{\bold{mod}\it n}$ $C_n$ |
| n-equal tone temperament[^5] | $\mathbb{C}$  | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{Z}, +, 0)$     | $e^{i2\pi g/n} x$        | $2^{\mathbb{Z}/n} f_0$ | $U_n$ $\mathbb{Z}/n{\mathbb{Z}}$ $\mathbb{Z}_{\bold{mod}\it n}$ $C_n$ |
| Octave-equivalent $p_n$-limit[^5]       | $\mathbb{R}$       | $f/f_0$                  | $(\mathbb{Z}^n, +, 0)$         | $\prod^n\_{i=1} p^{g\_i}\_i x$ | $\prod^n\_{i=1} p^{g\_i}\_i f_0$ $g \in \mathbb{Z}^n$ | $\mathbb{Z}^{n-1}$ |


## References

[^1]:[Simgle pitch space]({% post_url 2022-02-21-single-pitch-space %}) 
[^2]:[Group actions and tuning systems]({% post_url 2022-04-04-tuning-systems %}) 
[^3]:[Simple tuning systems]({% post_url 2022-05-16-simple-tuning-systems %}) and [Tuning systems are homogeneous spaces]({% post_url 2022-07-25-tuning-systems-are-homogeneous-spaces %})
[^4]: By exponental mapping.
[^5]:[Tuning systems with equivalence of the octaves]({% post_url 2029-02-07-tuning-systems-w-equivalence-of-the-octaves %}).
