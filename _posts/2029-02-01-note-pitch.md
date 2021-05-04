---
layout: post
title: Note's pitch
date: 2029-02-01 08:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

# Introduction

A few years ago, I decided to learn the guitar on my own. The last time I tried I was a teenager and it went nowhere. My initial goal was to learn something out of my comfort zone. Also, I always loved music and I felt as I was missing something important because I could not perform some music.

After a year into the process, playing a few minutes consistently every day, I got stuck. I figured the problem was that I felt lost in the fretboard, and no matter how much I played, I was no getting any new insights about how music works other than from my own (and relatively limited) intuition.

So started learning some music theory. For the first time, I understood the importance of scales, in particular, Major and Minor scales, triads, chord progression, etc. I felt like learning how to read and write for the first time. A world of patterns and traditions suddenly opened. At that moment, my most influential books were Guitar Theory for Dummies by Desi Serna[^1], and Basic Music Theory by Jonathan Harnum[^2]. As usual, after I got some of the basics, I had way more questions than when I started.

I was a scientist until a few years ago, and now I am an engineer. In my experience, I learn better when having a model to guide me in my learning process. The model does not need to be complete or even right and I always assume that its content might require constant updates.

With this blog, I will start a new series of notes about music. A lot of the content can be described as music theory. However, my goal is to provide a model to **help me** *to make and perform music*. Most of the content is my way of describing what I am reading about music, its representation, and its internal structure. I will provide as many references as I can without intention to be exhaustive.

I will be using what can be called axiomatically an approach. In it, I will be using simple definitions without taking too much time to justify them. I will be avoiding going too deep into the physics/acountic or psychoacoustics of music. However, I will provide as much references I am aware of if about each topic for active readers interested to follow up.

I will combining different definitions using concepts of Abstract Algebra inspired by books like A Geometry of Music by Dmitri Tymoczko[^4] or TODO and in a lesser sense TODO. However, I will following TODO notation and algebra concepts by superve Abstrac Algebra TODO reference.

I have little or no expertise about the details discussed in here, therefore a diclaimer inspire by MIT license wording:

{% include statement/disclaimer content="
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\"." %}

Therefore expect conceptual errors and constant updates the whole blog series.

# Music representation

There is a huge number of way to represent music. However, most of them fall in two categories[^3]:

* Literal notation: perfect representation of the music sound usually given and a time series.
* Symbolic notation: high level reprentation about the structure of of the music sound.

Signal processing uses for the most part some type of literal notation. By other hand, most of the music theory defines some kind of symbolic notation. For most of the initial blogs of this series I will be interested on discussing notes's pitch, its representation and combinations.

{% include statement/definition content="
the *pitch* of a note is the frequency of the sound represented by that note. As such, I say that for any pitch \\|x \in \mathcal{S}\\| has a frequency \\|f(x)\\| where \\|f: \mathcal{S} \rightarrow \mathbb{R}_{\geq0}\\| is a function from the pitch space \\|\mathcal{S}\\| to positive real numbers." %}

{% include statement/lemma content="
the *pitch* of a note is the frequency of the sound represented by that note. As such, I say that for any pitch \\|x \in \mathcal{S}\\| has a frequency \\|f(x)\\| where \\|f: \mathcal{S} \rightarrow \mathbb{R}_{\geq0}\\| is a function from the pitch space \\|\mathcal{S}\\| to positive real numbers." %}

**Example:**

# References

[^1]: [Guitar Theory for Dummies by Desi Serna](https://www.wiley.com/en-as/Guitar+Theory+For+Dummies%3A+Book+%2B+Online+Video+%26+Audio+Instruction-p-9781118646939)
[^2]: [Basic Music Theory by Jonathan Harnum](http://www.sol-ut.com/store/p1/Basic_Music_Theory%3A_How_to_Read%2C_Write%2C_and_Understand_Written_Music_%284th_edition%29.html).
[^3]: This clasification was inspired by [Rhythm and transforms by William Sethares, chap2, page 23](https://www.springer.com/gp/book/9781846286391)
[^4]: Tymoczko, Dmitri. A geometry of music: Harmony and counterpoint in the extended common practice. Oxford University Press, 2010.