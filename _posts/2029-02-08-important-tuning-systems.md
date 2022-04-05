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

| Tuning system           | $\mathcal{S}$        | $p(f)$            | $G$                            | $\lambda_g(x)$                 | $F$                                                   | $\mathcal{T}$         |
|-------------------------|----------------------|-------------------|--------------------------------|--------------------------------|-------------------------------------------------------|-----------------------|
| Positive-real[^1]      | $\mathbb{R}$         | $f/f_0$           | $(\mathbb{R}\_{>0}, \cdot, 1)$ | $gx$                           | $\mathbb{R}\_{>0}$                                    | $\mathbb{R}$          |
| Real[^1]                | $\mathbb{R}$         | $b\log_a(f/f_0)$  | $(\mathbb{R}, +, 0)$           | $g+x$                          | $\mathbb{R}\_{>0}$                                    | $\mathbb{R}$          |
| Equal ratio[^1]         | $\mathbb{R}$         | $f/f_0$           | $(a^{\mathbb{Z}/b}, \cdot, 1)$ | $gx$                           | $a^{\mathbb{Z}/b} f_0$                                | $\mathbb{Z}$          |
| Equal temperament[^1]   | $\mathbb{R}$         | $b\log_a(f/f_0)$  | $(\mathbb{Z}, +, 0)$           | $g+x$                          | $a^{\mathbb{Z}/b} f_0$                                | $\mathbb{Z}$          |
| $p_n$-limit[^1]         | $\mathbb{R}$         | $f/f_0$           | $(\mathbb{Z}^n, +, 0)$         | $\prod^n\_{i=1} p^{g\_i}\_i x$ | $\prod^n\_{i=1} p^{g\_i}\_i f_0$ $g \in \mathbb{Z}^n$ | $\mathbb{Z}^n$        |
| Octave-equivalent positive-real[^2]     | $\mathbb{C}$       | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{R}\_{>0}, \cdot, 1)$ | $e^{i2\pi\log_2(g)} x$         | $\mathbb{R}\_{>0}$                                    | $\mathbb{T}$ |
| Octave-equivalent real[^2]              | $\mathbb{C}$       | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{R}, +, 0)$           | $e^{i2\pi g} x$                | $\mathbb{R}\_{>0}$                                    | $\mathbb{T}$ |
| n-equal tone ration[^2]      | $\mathbb{C}$  | $e^{i2\pi f/f_0}$  | $(2^{\mathbb{Z}/n}, \cdot, 1)$ | $e^{i2\pi n\log_2(g)} x$ | $2^{\mathbb{Z}/n} f_0$ | $U_n$ $\mathbb{Z}/n{\mathbb{Z}}$ $\mathbb{Z}_{\bold{mod}\it n}$ $C_n$ |
| n-equal tone temperament[^2] | $\mathbb{C}$  | $e^{i2\pi\log_2(f/f_0)}$ | $(\mathbb{Z}, +, 0)$     | $e^{i2\pi g/n} x$        | $2^{\mathbb{Z}/n} f_0$ | $U_n$ $\mathbb{Z}/n{\mathbb{Z}}$ $\mathbb{Z}_{\bold{mod}\it n}$ $C_n$ |
| Octave-equivalent $p_n$-limit[^2]       | $\mathbb{R}$       | $f/f_0$                  | $(\mathbb{Z}^n, +, 0)$         | $\prod^n\_{i=1} p^{g\_i}\_i x$ | $\prod^n\_{i=1} p^{g\_i}\_i f_0$ $g \in \mathbb{Z}^n$ | $\mathbb{Z}^{n-1}$ |

## References

[^1]:[Simple tuning systems]({% post_url 2029-02-04-simple-tuning-systems %}) and [Tuning systems are homogeneous spaces]({% post_url 2029-02-05-tuning-systems-are-homogeneous-spaces %})
[^2]:[Tuning systems with equivalence of the octaves]({% post_url 2029-02-07-tuning-systems-w-equivalence-of-the-octaves %}).
