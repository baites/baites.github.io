---
layout: post
title: Single pitch space
date: 2029-02-02 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

# Music representation

There is a huge number of way to represent music. However, most of them fall in two categories[^3]:

* Literal notation: perfect representation of the music sound usually given and a time series.
* Symbolic notation: high level reprentation about the structure of of the music sound.

Signal processing uses for the most part some type of literal notation. By other hand, most of the music theory defines some kind of symbolic notation. For most of the initial blogs of this series I will be interested on discussing notes's pitch, its representation and combinations.

{% include statement/definition %}
the *pitch* of a note is the frequency of the sound represented by that note. As such, I say that for any pitch $x \in \mathcal{S}$ has a frequency $f(x)$ where $f: \mathcal{S} \rightarrow \mathbb{R}_{\geq0}$ is a function from the pitch space $\mathcal{S}$ to positive real numbers.
{% include statement/end %}


**Example:**

# References

[^1]: [Guitar Theory for Dummies by Desi Serna](https://www.wiley.com/en-as/Guitar+Theory+For+Dummies%3A+Book+%2B+Online+Video+%26+Audio+Instruction-p-9781118646939)
[^2]: [Basic Music Theory by Jonathan Harnum](http://www.sol-ut.com/store/p1/Basic_Music_Theory%3A_How_to_Read%2C_Write%2C_and_Understand_Written_Music_%284th_edition%29.html).
[^3]: This clasification was inspired by [Rhythm and transforms by William Sethares, chap2, page 23](https://www.springer.com/gp/book/9781846286391)
[^4]: Tymoczko, Dmitri. A geometry of music: Harmony and counterpoint in the extended common practice. Oxford University Press, 2010.