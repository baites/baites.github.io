---
layout: post
title: "Median of two sorted arrays"
date: 2019-02-25 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

## Here I go again

It being a while since my last post. I stopped blogging for a while because of some personal issues I need to resolve. However, these are technical blogs that are not meant to be mass produced. I write them with the intention of practicing my writing, get some bragging rights about my creative and knowledge (or lack of them), and more important because I enjoy it.

## Formalizing algorithms

I decided I needed to formalize my knowledge of algorithms. Although I work with them all my life, I never was *classically train* on algorithms and I decided it was time for me to do it.

Although I am trying several things that I might blog later in the future, one important thing is to practice algorithms. I started looking at LeetCode[^1] for practicing algorithms and this blog is about the first **hard** problem I solved from the site.

I have not read the solution yet although it can be find on the site. I am giving my word that I only look for the definition of the median of an array that I will provide below. Once I am done posting the blog, I will read about other solutions or discuss it with people deep in algorithmic games. I will update the post later doing some comparison between solutions.

## The problem

Before going to the specific problem we need to define what is the median of an array.

> **Definition:** Given an assorted array \\|A[0..S-1]\\| where \\|S\\| is the array size its median is defined as:
<p>%%
Median(A) = \begin{cases}
A[m] & \text{if S is odd} \\
\frac{1}{2} \lparen A[m] + A[m - 1] \rparen  & \text{otherwise}
\end{cases}
%%</p>
>where \\|m = \lfloor S/2 \rfloor \\| is the index pointing to the *middle* of the array.

### References

[^1]: [LeetCode](https://leetcode.com/)
