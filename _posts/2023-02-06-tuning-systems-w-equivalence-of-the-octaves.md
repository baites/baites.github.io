---
layout: post
title: Tuning systems with equivalence of the octaves
date: 2023-02-06 08:00:00 -0400
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
> an octave or perfect eight is the interval between one musical pitch and another with double its frequency. The human ear tends to hear both notes as being essentially *the same*, due to closely related harmonics ... The interval is so natural to humans that when men and women are asked to sing in unison, they typically sing an octave apart.[^1]

The perceived similar quality often rises to the status of equivalence. As such, it is customary in occidental tradition to use the same notation for two pitches whose frequency ratio is some power of two or octaves apart. This equivalence is not without some controversy. My emotional reaction is usually different for notes that are an octave apart. For example, when U2 sings [With or Without](https://en.wikipedia.org/wiki/With_or_Without_You), Bono signs the whole song one octave up by the end of the song, adding dramatism and also making the song particularly hard to sing.

There is a deep connection between the notion of consonance and the timbre or tone of a sound source. In one of the most fantastic books I have ever read, Sethares shows how to make an octave dissonant by synthesizing a sound with a carefully chosen timbre[^3]. You can hear it yourself on Sethares's webpage; search for *The Octave is Dead... Long Live the Octave*[^4].

In this blog, I will ignore the psychoacoustic details[^5]. Instead, I will concentrate on the algebra of having a tuning system in which octaves are equivalents.

## Octave equivalence in real tuning-systems

### Positive-real octave-equivalent tuning system

Let $\mathcal{S}$ be single pitch space from by the set of complex numbers $\mathbb{C}$ and the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi\log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}\_{>0}, \cdot, 1)$ and map $\lambda_x: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(\log_2(x))z$ with the homorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. I call this tuning system **octave-equivalent positive-real tuning system**.

This tuning systems is octave equivalence because the kernel $\text{Ker}\_{\phi}$ is all $x \in \mathbb{R}\_{>0}$ such $e^{i2\pi\log_2(x)} = 1$, or equivalent, $\text{Ker}\_{\phi} = \lbrace 2^n \| n \in \mathbb{Z} \rbrace = 2^{\mathbb{Z}}$. Therefore, by the *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{R}\_{>0}/2^{\mathbb{Z}}$. The figure below shows a graphical representation of a pitch with coordinate $x = 1.2$[^200]. The pitch $x$ has *images* of equivalent pitches $x'$ forming what I call overtone the overtone for $x' > x$ and undertone octaves $x' < x$[^7]. In algebra, it is common to notate all the class of equivalent pitches as $1.2 \cdot 2^{\mathbb{Z}}$.

{% include image file="mt-positive-real-octave-equivalent-system.svg" scale="100%" %}

### Real octave-equivalent tuning system

I can provide an alternative description to the previous tuning system. Let $\mathcal{S}$ be single pitch space from by the set of complex numbers $\mathbb{C}$ and the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi\log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{R}, +, 0)$ and map $\lambda_g: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(x)z$ with the homomorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. I call this tuning system **octave-equivalent real tuning system**. As before, using *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{R}/\mathbb{Z}$.

The relationship between this system and the previous one is given by the isomorphism $\log_2: (\mathbb{R}\_{>0}, \cdot, 1) \rightarrow (\mathbb{R}, +, 0); x \mapsto \log\_2(x)$. The figure below presents the graphical representation of this tuning system that is basically the same as the previous figure but just in logarithmic scale base two, where $x$ coordinate is $\log_2(1.2) + \mathbb{Z}$[^201].

{% include image file="mt-real-octave-equivalent-system.svg" scale="100%" %}

### Real octave-equivalent tuning systems are group circle

Both of the previous tuning systems are constructed using homomorphism $\phi: \mathbb{R} \rightarrow \mathbb{C}; x \mapsto e^{i2\pi x}$. The function image $\phi(\mathbb{R})$ is the set of complex element $z$ such $\vert z \vert - 1 = 0$ that is notated as $\mathbb{T}$[^8]. The $(\mathbb{T}, \cdot, 1)$ from a group known as *circle group* based on the multiplication of complex multiplication.

Using the *First Isomorphism Theorem for Groups* the homomorphism $\phi$ implies there are the following group isomorphisms between $\mathbb{R}/2^{\mathbb{Z}} \simeq \mathbb{T}$ and $\mathbb{R}/\mathbb{Z} \simeq \mathbb{T}$.[^6] Therefore, the pitch classes for both positive-real and real tuning systems are isomorphic to the circle group. In the graph below an example of $\mathbb{T}$ and the pitch $x$ given by $e^{2\pi\cdot[\log_2(1.2)+\mathbb{Z}]}$.

The main benefit of using a circle group as a pitch class is that each distinct circle point is a different (as not equivalent) pitch. The equivalent images are simply an integer number of loops around the circle[^202].

{% include image file="mt-circle-group.svg" scale="70%" %}

## Octave equivalence in the equal-temperament tuning system

Let $\mathcal{S}$ be the set of all reals $\mathbb{C}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{C}; f \mapsto e^{i2\pi \log_2(f/f_0)}$ such as the pitch $z = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{Z}, +, 0)$ and map $\lambda_k: \mathbb{C} \rightarrow \mathbb{C}; z \mapsto \phi(k)z$ with the homomorphism $\phi: \mathbb{Z} \rightarrow \mathbb{C}; k \mapsto e^{i2\pi k/n}$ for some $n \in \mathbb{N}$. This tuning system is my definition of **n-tone equal temperament**. The kernel $\text{Ker}\_{\phi}$ is all $k \in \mathbb{Z}\_{>0}$ such $e^{i2\pi k/n} = 1$, or equivalent, $\text{Ker}\_{\phi} = \lbrace nh \| h \in \mathbb{Z} \rbrace = n \mathbb{Z}$. By the *pitch class for simple-action tuning system* lemma[^6], the tuning system pitch class is $\mathbb{Z}/n{\mathbb{Z}}$. In this system there is only a subset of frequencies with values given by $f_k = 2^{k/n} f_0$ such as $p(f_k) = e^{i2\pi k/n}$ for $k \in \mathbb{Z}$.

The pitch class $\mathbb{Z}/n{\mathbb{Z}}$ can be represented in many ways as it is isomorphic to a large number of known groups, like modular arithmetic group $\mathbb{Z}_{\bold{mod}\it n}$[^9] or the cyclic group $C_n$[^10]. However, in the music context, the preferred representation is the group of the root of unity $U_n$ defined as the set of $z \in \mathbb{C}$ such $z^n - 1 = 0$.[^11] This representation is a set of $n$ points equally distributed over a unit circle like a clock[^203]. This is because $z_k = e^{i2\pi k/n}$ for $k \in \mathbb{Z}$ are the root of unity equation.

{% include image file="mt-twelve-tet.svg" scale="70%" %}

## Octave equivalence in $p_n$-limit tuning system

Let $\mathcal{S}$ be the set of positive reals $\mathbb{R}\_{>0}$ and with function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; f \mapsto f/f_0$ such as the pitch $x = 1$ is the standard pitch of frequency $f_0$. Let me define a group action with group $(\mathbb{Z}^n, +, 0)$ and map $\lambda_g: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; x \mapsto \phi(g)x$ with the homomorphism $\phi: \mathbb{Z}^n \rightarrow \mathbb{R}\_{>0}; g \mapsto \prod^n\_{i=2} p^{g\_i}\_i$ for $p_1,p_2,..., p_n$ the first n-th prime numbers larger than 1. It is important to realize that I define the homomorphism ignoring the contribution $p_1 = 2$, ignoring the value of $g_1$. I call **octave-quivalent $p_n$-limit tuning system** with a pitch class of $\mathbb{Z}^{n-1}$ as any value of $(x, g_2, ..., g_n)$ is equivalent to $(y, g_2, ..., g_n)$ for any $x,y \in \mathbb{Z}$.

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: [Wiki entry: Octave](https://en.wikipedia.org/wiki/Octave)
[^2]: [Blog about tuning systems.]({% post_url 2022-04-04-tuning-systems %})
[^3]: Sethares, William A. Tuning, timbre, spectrum, scale. Springer Science & Business Media, 2005.
[^4]: [Sound Examples for Tuning Timbre Spectrum Scale](https://sethares.engr.wisc.edu/html/soundexamples.html)
[^5]: Most of the referances comes from *Consonance and Dissonance of Harmonic Sounds*, chap5 in Sathares' book[^3].
[^6]: [Tuning systems by simple actions]({% post_url 2022-12-26-tuning-systems-by-simple-actions %})
[^7]: The name of overtone and undertone octaves are expired by the definition of the [overtone series](https://en.wikipedia.org/wiki/Harmonic_series_(music)) and [undertone series](https://en.wikipedia.org/wiki/Undertone_series).
[^8]: [Wiki entry: circle group](https://en.wikipedia.org/wiki/Circle_group).
[^9]: Section 3.5 of [^100].
[^10]: Example 2.30 of [^100].
[^11]: [Wiki entry: root of unity](https://en.wikipedia.org/wiki/Root_of_unity)
[^100]: Smith, Jonathan DH. Introduction to abstract algebra. Vol. 31. CRC Press, 2015.
[^200]: Code to generate the graph can be found in my [github account](https://github.com/baites/examples/blob/master/music/python/orbichords/tuning_systems/positive_real_octave_equivalent_system.py).
[^201]: Code to generate the graph can be found in my [github account](https://github.com/baites/examples/blob/master/music/python/orbichords/tuning_systems/real_octave_equivalent_system.py).
[^202]: Code to generate the graph can be found in my [github account](https://github.com/baites/examples/blob/master/music/python/orbichords/tuning_systems/circle_group.py).
[^203]: Code to generate the graph can be found in my [github account](https://github.com/baites/examples/blob/master/music/python/orbichords/tuning_systems/root_of_unity.py).