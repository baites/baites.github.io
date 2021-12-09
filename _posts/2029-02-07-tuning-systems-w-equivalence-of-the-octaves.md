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

As per the wiki perdia:
> an octave or perfect eight is the interval between one musical pitch and another with double its frequency. The human ear tends to hear both notes as being essentially "the same", due to closely related harmonics ... The interval is so natural to humans that when men and women are asked to sing in unison, they typically sing in octave.[^1]

The percieved similar quality is often raisen to the status of equivalence. As such, it is customary in occidental tradition to use the same notation for two pitches which frequency ratio is some power of two or octaves apart. This equivalence is in my opinion no without some controversy. My emotional reaction is usually not the same for pitches that are octave apart. For example, when U2's sings [With or Without](https://en.wikipedia.org/wiki/With_or_Without_You) Bono signs the whole song one octave up by the end of the song to add dramatism (and make it really hard to sing by anybody else).

Mover there is a deep connection between the notion of consonance and the timbre or tone of source of sound. In one of the most amazing book I ever read, Sethares shows how to destroy octave consonance by change of synthezise sound[^3]. You can hear it yourself in Sethares's webpage, look for *The Octave is Dead... Long Live the Octave*[^4].

In this blog, I will ignore the psychoacoustic[^5]. Instead I will concentrate in the algebra of having tuning system where octaves are equivalents.

## Octave equivalence in real tuning-systems

### Positive-real octave-equivalent tuning system

Let $\mathcal{S}$ be single pitch space from by the set of complex numbers $\mathbb{C}$ and the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi\log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}\_{>0}, \cdot, 1)$ and map $\lambda_x: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(\log_2(x))z$ with the homorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. I call this tuning system **positive-real octave-equivalent tuning system**.

This tuning systems is octave equivalence because the kernel $\text{Ker}\_{\phi}$ is all $x \in \mathbb{R}\_{>0}$ such $e^{i2\pi\log_2(x)} = 1$, or equivalent, $\text{Ker}\_{\phi} = \lbrace 2^n \| n \in \mathbb{Z} \rbrace = 2^{\mathbb{Z}}$. Therefore, by the *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{R}\_{>0}/2^{\mathbb{Z}}$. The figure below shows a graphical representation for a pitch with coordinate $x = 1.2$. The pitch $x$ has *images* of equivalent pithes $x'$ forming what I call overtone the overtone for $x' > x$ and undertone octaves $x' < x$[^7]. In algebra it is common to notate the all the class of equivalent pitches as $1.2 \cdot 2^{\mathbb{Z}}$.

{% include image file="mt-positive-real-octave-equivalent-system.svg" scale="100%" %}

### Real octave-equivalent tuning system

I can provide an alternative decription to the previous tuning system. Let $\mathcal{S}$ be single pitch space from by the set of complex numbers $\mathbb{C}$ and the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi\log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}, +, 0)$ and map $\lambda_g: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(x)z$ with the homomorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. I call this tuning system **real octave-equivalent tuning system**. As before, using *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{R}/\mathbb{Z}$.

The relationshipt between this system and the previous one is given by the isomorphism $\log_2: (\mathbb{R}\_{>0}, \cdot, 1) \rightarrow (\mathbb{R}, +, 0); x \mapsto \log\_2(x)$. The figure below presents the graphical representation of this tuning system that is basically the same a previous figure but just in logarithmic scale base two, where $x$ coordinate is $\log_2(1.2) + \mathbb{Z}$.

{% include image file="mt-real-octave-equivalent-system.svg" scale="100%" %}

### Real octave-equivalent tuning systems are group circle

Both of the previous tuning systems are constructed using homormorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. The function image $\phi(\mathbb{R})$ is the set of complex element $z$ such $\vert z \vert - 1 = 0$ that is notated as $\mathbb{T}$[^8]. The $(\mathbb{T}, \cdot, 1)$ from a group known as *circle group* where $\cdot$ complex multiplication.

Using the *First Isomorphism Theorem for Groups* the homomorphism $\phi$ implies there are the following group isomorphisms between $\mathbb{R}/2^{\mathbb{Z}} \simeq \mathbb{T}$ and $\mathbb{R}/\mathbb{Z} \simeq \mathbb{T}$.[^6] Therefore, the pitch class for both positive-real and real tuning system are isomorphic to the circle group. In the graph below an example of $\mathbb{T}$ and the pitch $x$ given by $e^{2\pi\cdot[\log_2(1.2)+\mathbb{Z}]}$.

The main benefit of using circle group as pitch class is that each distinct point of the circle is a different (as no equivalent) pitch. The equivalent images are just simply an integer number of loop around the circle.

{% include image file="mt-circle-group.svg" scale="70%" %}

## Octave equivalence in equal-temperament tuning system

Let $\mathcal{S}$ be the set of all reals $\mathbb{C}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi \log_2(f/f_0)}$ such as the pitch $x = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{Z}, +, 0)$ and map $\lambda_k: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(k)z$ with the homomorphism $\phi: \mathbb{Z} \rightarrow \mathbb{C}; k \mapsto e^{i2\pi k/n}$ for some $n \in \mathbb{N}$. This tuning system is my definition of **n-tone equal temperament**. The kernel $\text{Ker}\_{\phi}$ is all $k \in \mathbb{Z}\_{>0}$ such $e^{i2\pi k/n} = 1$, or equivalent, $\text{Ker}\_{\phi} = \lbrace nh \| h \in \mathbb{Z} \rbrace = n \mathbb{Z}$. By the *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{Z}/n{\mathbb{Z}}$. This system is therefore the discrete version of a real tuning system. Only a subset of frequencies are associated to this tuning system with values given by $f_k = 2^{k/n} f_0$ such as $p(f_k) = e^{i2\pi k/n}$ for $k \in \mathbb{Z}$.

The pitch class $\mathbb{Z}/n{\mathbb{Z}}$ can be represented in many ways as it is isomorphic to large number of useful groups, like modular arithmetic group $\mathbb{Z}_{\bold{mod}\it n}$[^9] or the cyclic group $C_n$[^10]. However, in music context the prefer representation is the group of root of unity $U_n$ defined as the set of $z \in \mathbb{C}$ such $z^n - 1 = 0$.[^11] This representation is simply set of $n$ points of equally distributed over unit circle like a clock. This is because $z_k = e^{i2\pi k/n}$ for $k \in \mathbb{Z}$ are the root of unity equation.

{% include image file="mt-twelve-tet.svg" scale="70%" %}

## References

[^1]: [Wiki entry: Octave](https://en.wikipedia.org/wiki/Octave)
[^2]: [Blog about tuning systems.]({% post_url 2029-02-03-tuning-systems %})
[^3]: Sethares, William A. Tuning, timbre, spectrum, scale. Springer Science & Business Media, 2005.
[^4]: [Sound Examples for Tuning Timbre Spectrum Scale](https://sethares.engr.wisc.edu/html/soundexamples.html)
[^5]: Most of the referances comes from *Consonance and Dissonance of Harmonic Sounds*, chap5 in Sathares' book[^3].
[^6]: [Tuning systems by simple actions]({% post_url 2029-02-06-tuning-systems-by-simple-actions %})
[^7]: The name of overtone and undertone octaves are expired by the definition of the [overtone series](https://en.wikipedia.org/wiki/Harmonic_series_(music)) and [undertone series](https://en.wikipedia.org/wiki/Undertone_series).
[^8]: [Wiki entry: circle group](https://en.wikipedia.org/wiki/Circle_group).
[^9]: Section 3.5 of [^100].
[^10]: Example 2.30 of [^100].
[^11]: [Wiki entry: root of unity](https://en.wikipedia.org/wiki/Root_of_unity)
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
