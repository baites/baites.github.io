---
layout: post
title: Simple tuning systems
date: 2029-02-04 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Introduction

In a previos blog I introduced pitch sets called [tuning systems]({% post_url 2029-02-03-tuning-systems %}). My goal in this blog is to present several examples of simple tunings. Please be aware some of the names below are made up by me.

## Simple tuning systems

### Positive-real tuning system

Let $\mathcal{S}$ be the set of positive reals $\mathbb{R}\_{>0}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; f \mapsto f/f_0$ such as the pitch $x = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}\_{>0}, \cdot, 1)$ and map $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; x \mapsto gx$ for any $g \in \mathbb{R}\_{>0}$. The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}\_{>0}}(1)$ and I call it **positive-real tuning system**.

The positive-real tuning system naturaly appears when working with sound generators or synthesizers. This systems just take a standard pitch and scales its frequence by positive real value $g$.

### Real tuning system

Let $\mathcal{S}$ be the set of all reals $\mathbb{R}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{R}; f \mapsto b\log_a(f/f_0)$ for some $a,b \in \mathbb{R}\_{>0}$ such as the pitch $x = 0$ is the standard pitch of frequency $f_0$. Let me define the group action with group $(\mathbb{R}, +, 0)$ and a map $\lambda_g: \mathbb{R} \rightarrow \mathbb{R}; x \mapsto g + x$ for any $g \in \mathbb{R}$. The tuning systems is then given by the the orbit $\mathcal{T} = \lambda_{\mathbb{R}}(0)$ and I call it **real tuning system**.

The real tuning system is basically the same as positive-real tuning system where the group action operation is given by the sum. This is done by exponentation where $g$ of $\mathbb{R}$ can be transform to $g' \in \mathbb{R}\_{>0}$ of a positive-real tuning system by $g' = \exp_a(g/b)$.

### $p_n$-limit tuning system

Let $\mathcal{S}$ be the set of positive reals $\mathbb{R}\_{>0}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; f \mapsto f/f_0$ such as the pitch $x = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{Z}^n, +, 0)$ and map $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; x \mapsto \prod^n\_{i=1} p^{g\_i}\_i x$ for any $g \in \mathbb{Z}^n$ and $p_1,..., p_n$ the first n-th prime numbers. I call **$p_n$-limit tuning system** to the orbit $\mathcal{T} = \lambda\_{\mathbb{Z}^n}(1)$.

The tuning system is commonly assocated with tradition of just intonation[^1]. It is a rather complex tuning system to generate a simple pitch space. Each pitch is associated with a n-dimentional vector of integers or $\mathbb{Z}^n$. Therefore, it is customary to reduce the complexity of these system by limiting the dimension as for example in the case of the five-limit tuning[^2].

## The *structure* of tuning systems

A natural question from the previous tuning systems $\mathcal{T}$ is what kind of set they form. How the tuning systems $\mathcal{T}$ are related to the group $G$ used to generate them. How the group structure of tuning-system group manifest in the tuning system set. In this blog will answer this questions informally for the previous three tuning system.

By definition, any element $b$ of the positive-real tuning system $\mathcal{T}$ there is an $x \in \mathbb{R}\_{>0}$ such as $b = x$. The relationship between $b$ (element of the tuning system) and $x$ (element of the tuning-system group) is one-to-one because both are basically represented by the same real number. Therefore, I would expect that positive-real tuning system has the same structure as positive real number using the notation $\mathcal{T} \simeq \mathbb{R}\_{>0}$, or $\lambda_{\mathbb{R}\_{>0}}(1) \simeq \mathbb{R}\_{>0}$. Following the same heuristic about the other examples of tuning systems, it is not hard to see that for real tuning system $\lambda_{\mathbb{R}}(0) \simeq \mathbb{R}$, and for $p_n$-limit tuning system $\lambda\_{\mathbb{Z}^n}(1) \simeq \mathbb{Z}^n$.

## Reference

[^1]: [Wiki entry: Just intonation](https://en.wikipedia.org/wiki/Just_intonation).
[^2]: [Wiki entry: five-limit tuning](https://en.wikipedia.org/wiki/Five-limit_tuning).