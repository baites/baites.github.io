---
layout: post
title: Simple pitch space
date: 2029-02-02 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Music representations

There are a large number of ways music representations. Most of them fall into two categories:[^1]

* Literal notation: a perfect representation of the music sound usually given and a time series.
* Symbolic notation: high-level representation of the structure of the music sound.

Literal notation is used for the most part for recording or signal processing. For example, digital recording uses files of sample sounds. A mono sample file is simply a large array containing the sound amplitude at each sampled point in time.

Alternatively, most musicians and music researchers use some
kind of symbolic notation. These notations hide the details of the sound, concentrating on a more salient feature of the music. These notations are oriented to assist musicians when performing like it is the case music sheets.

## Musical note

The simplest symbolic representation is a musical note. In music, a note is a symbol denoting sound.[^2] At a minimum, notes express the duration and the pitch and of a sound. The duration is just how long a sound persists. The pitch of a sound **represents** *a perceptual property of the sound that makes it possible to judge sounds as "higher" and "lower" in the sense associated with musical melodies.*[^3]

I want to emphasize I think the pitch of a note as an abstract musical object. It is not something that can be extracted directly from a sound because a pitch represents a property of a sound, and the way a listener perceives it. However, it is possible to account for the listener's perception of simple sounds like those produced by a simple-tone sound generator. This is how the Acoustical Society of America (ASA) alternatively says that *the pitch of a sound may be described by the frequency of that simple tone having a specified sound pressure level that is judged by listeners to produce the same pitch.*[^4]

## Simple pitch space

Based on the above discussion, I will advance the following definition.

{% include statement/definition name="simple pitch space" %}
Pitch is an abtract musical object related to a musical note. A collection of single pitches form a *simple pitch space* that is denoted by $\mathcal{S}$. Associated to the pitch space there is a function $p: \mathbb{R}\_{>0} \rightarrow \mathcal{S}$ such as for each frequency $f$ we can assign the pitch $p(f)$.
{% include statement/end %}

I like to emphasize that each element of the simple pitch space is a single or simple pitch. I will discuss musical objects based on two or more pitches later on in the series. Also, for single-pitch space, it is always possible associate a pitch for given frequency value. The other way around is often no true as one pitch might associated to a collection of frequencies.[^5]

I will say that any set that satisfied the definition of simple-pitch space is a particurlar *instance* or *representation* of a simple-pitch space. Below, I show two examples of simple-pitch space instances.

{% include statement/example name="Positive reals as single pitch space" %}
The set $\mathbb{R}\_{>0}$ and with the function $p: \mathbb{R}\_{>0} \rightarrow \mathbb{R}\_{>0}; f \mapsto cf$ for any constant $c \in \mathbb{R}\_{>0}$ is a single pitch space.
{% include statement/end %}

{% include statement/example name="Reals as single pitch space" %}
The set $\mathbb{R}$ and with the function $p: \mathbb{R} \rightarrow \mathbb{R}\_{>0}; f \mapsto b \log_a(cf) $ for any constants $a, b, c \in \mathbb{R}\_{>0}$ is a single pitch space.
{% include statement/end %}

The simple pitch space as a concept is not very practical due to its lack of structure or regularity. The definition basically says that for a frequency value we can map it to an abstract object called pitch. In the next blog, I will improve the above description by identifying a more exciting collection of pitches within simple pitch space.

## References

[^1]: This clasification was inspired by [Rhythm and transforms by William Sethares, chap2, page 23](https://www.springer.com/gp/book/9781846286391)
[^2]: [Wikipedia entry: Musical note](https://en.wikipedia.org/wiki/Musical_note).
[^3]: [Wikipedia entry: Pitch (music)](https://en.wikipedia.org/wiki/Pitch_(music)).
[^4]: [ASA definition of pitch Annotation 2](https://asastandards.org/Terms/pitch/).
[^5]: In chromatic scale, the standard pitch $A_4$ (or $A$ of fourth octave) is defined as having a frequency of $440 \text{khz}$. However, if octave is ignored (equivalence of the octaves) when the standard pitch $A$ is associated to the following set of frequencies $\big\lbrace 2^{(n-4)} \cdot 440 \text{khz} \vert n \in \mathbb{Z} \big\rbrace$. The index $n$ enumerates the octaves.