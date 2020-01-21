---
layout: post
title: Solving longest palindromic substring with hashing
date: 2030-01-15 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

* TOC
{:toc}

## Intro (TODO)

Do the INTRO[^1].

## Longest palindromic substring

Lets start with the problem definition.

> **Problem:** Given a string \\|S\\|, find the longest palindromic substring in s. You may assume that the maximum length of \\|\|S\|\\| is 1000.

> **Definitions**: For a string \\|S\\| of length \\|L\\|, I define its **reverse string** to the string \\|R\\| of the same length such as \\|R[i] = S[L-i-1]\\|. A string \\|S\\| is **a palindrome** if it is equal to its reverse string \\|R\\|.

## Hashing strings with polyhash

### Polyhash

> **Definition:** Given a string \\|S\\| of length \\|L\\|, the polyhash \\|H(S)\\| of that string is give by

<p>%%
H_S = \left(\sum^{L-1}_{i=0} S[i] x^{i} \right) \text{mod } p
%%</p>

>where \\|p\\| is a prime (and usually large) number, and \\|x\\| some integer \\|x \in [1, p-1]\\|.

It is trivial to see that the polyhash value for identical strings is the same. The question is therefore what happen for two distinct strings. The following lemma answer this question by saying that the probability of for two different strings to share the same hash is very low[^2].

> **Lemma:** For any two string \\|S\\| and \\|Q\\| of length at most \\|L+1\\|, and  a polyhash created by selecting at random a \\|x \in [1,p-1]\\| for some prime \\|p\\|, then the probability of both string having the same hash is bound by

<p>%%
\text{Prob}[H_{S} = H_{Q}] \leq \frac{L}{p}
%%</p>

> **Corollary:** For a non-palindromic string \\|S\\| of length \\|L\\| and its reverse string \\|R\\|, plus a polyhash as define in the previous lemma, then the probability of both string having the same hash is bound by

<p>%%
\text{Prob}[H_{S} = H_{R}] \leq \frac{L}{p}
%%</p>

### Forward and backward hashes

> **Definition:** Given a string \\|S\\| I define its forward hashes \\|F_S[n]\\| as the hash values of the \\|n\\|-size prefixes of \\|S\\| or  

<p>%%
F_S[n] = \left(\sum^{n-1}_{i=0} S[i] x^{i} \right) \text{mod } p
%%</p>

> where arbitrarily I choose the value of \\|F_S[0] = 0\\|.

It is easy to see that for string S of length L its hash value is \\|F_S[L]\\|.

> **Definition:** Given a string \\|S\\| I define its backward hashes \\|B_S[n]\\| as the hash values of the \\|n\\|-size suffixes of \\|S\\| or  

<p>%%
B_S[n] = \left(\sum^{L-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
%%</p>

> where arbitrarily I choose the value of \\|B_S[0] = 0\\|.

Also, it is easy to see that for string S of length L its hash value is \\|B_S[L]\\|.

Now if a string \\|S\\| is palindrome then its hash value \\|F_S[L]\\| is equal to the hash value of its reverse string \\|F_R[L]\\| that is also equal to \\|B_R[L]\\|.
Therefore, for a palindrome \\|S\\| is true that \\|F_S[L] = B_R[L]\\|.

More importantly, if \\|S\\| contains a \\|n\\|-sized palindromic prefix, then it is easy to see that \\|F_S[n] = B_R[n]\\|, that is the \\|n\\|-th forward hash of the string has to be the same as the \\|n\\|-th backward hash of the reverse string. Conversely, the probability for a string of having non-palindromic prefix of size \\|n\\| such as \\|F_S[n] = B_R[n]\\| cannot be higher than \\|n/p\\| based on the corollary of the previous section.

### Computing forward and backward hashes

> **Proposition:** The forward hashes for the string \\|S\\| are related by the following recurrence:

<p>%%
F_S[n+1] = \left(F_S[n] + x^nS[n]\right) \text{ mod } p
%%</p>

**Proof**:

<p>%%
\begin{aligned}
F_S[n+1] &= \left(\sum^{n}_{i=0} S[i] x^i \right) \text{mod } p \\
         &= \left(\sum^{n-1}_{i=0} S[i] x^i + x^n S[n]\right) \text{mod } p \\
         &= \left(F_S[n] + x^n S[n]\right) \text{mod } p       
\end{aligned}
%%</p>

> **Proposition:** The backwards hashes for the reverse string \\|R\\| of \\|S\\| are related by the following recurrence:

<p>%%
B_R[n+1] = \left(xB_R[n] + S[n]\right) \text{ mod } p
%%</p>

**Proof**:

<p>%%
\begin{aligned}
B_R[n+1] &= \left(\sum^{L-1}_{i=L-n-1} S[L-i-1] x^{i-L+n+1} \right) \text{mod } p \\
         &= \left(\sum^{L-1}_{i=L-n} S[L-i-1] x^{i-L+n+1} + S[n]\right) \text{mod } p \\
         &= \left(x\sum^{L-1}_{i=L-n} S[L-i-1] x^{i-L+n} + S[n]\right) \text{mod } p \\
         &= \left(xB_R[n] + S[n]\right) \text{ mod } p
\end{aligned}
%%</p>

## Forward and backward hashes of a substring

### Defining forward and backward hashes for substrings

It is easy to generalize the notion of forward hash for a substring \\|S[m..n]\\| as simply the hash value of the substring.

> **Definition:** Given a substring \\|S[m..n]\\| I define its forward hash \\|F_S[m..n]\\| as the hash value given by

<p>%%
F_S[m..n] = H(S[m..n]) = \left(\sum^{n-1}_{i=m} S[i] x^{i-m} \right) \text{mod } p
%%</p>

> **Definition:** Given a substring \\|S[m..n]\\| I define its backward hash \\|B_S[m..n]\\| as the hash value given by

<p>%%
B_S[m..n] = H(S[L-n..L-m]) = \left(\sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
%%</p>

It is easy to see that under these definitions \\|F_S[0..n] = F_S[n]\\| and \\|B_S[0..n] = B_S[n]\\|.

> **Proposition:** For a substring \\|S[m..n]\\| we have
> * if it is a palindrome then
<p>%%
F_S[m..n] = B_R[m..n]
%%</p>
> * otherwise
<p>%%
\text{Prob}(F_S[m..n] = B_R[m..n]) \leq (n-m)/p
%%</p>

### Computing forward and backward hashes for substrings

<p>%%
F_S[n] - F_S[m] = x^m F_S[m..n]
%%</p>

<p>%%
\begin{aligned}
B_S[n] - x^{n-m} B_S[m] &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - x^{n-m} \sum^{L-1}_{i=L-m} S[i] x^{i-L+m} \\
                        &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - \sum^{L-1}_{i=L-m} S[i] x^{i-L+n} \\
                        &= \sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \\
                        &= B_S[m..n]
\end{aligned}
%%</p>

<p>%%
F_S[n] - F_S[m] = x^m B_R[n] - x^n B_R[m]
%%</p>

## Modular arithmetic

* \\|(a \text{ mod } p) \text{ mod } p = a \text{ mod } p\\|
* \\|(a + b) \text{ mod } p =(a \text{ mod } p + b \text{ mod } p) \text{ mod } p\\|
* \\|(a \times b) \text{ mod } p =(a \text{ mod } p \times b \text{ mod } p) \text{ mod } p\\|
* \\|c = (a/b) \text{ mod } p \text{ iff exist a integer } c \text{ so } (b \times c) \text{ mod } p = a \\|[^3]

## References

[^1]: [LeetCode](https://leetcode.com/)
[^2]: Reference to the lemma demonstration.
[^3]: [GeeksForGeeks: modular division](https://www.geeksforgeeks.org/modular-division/)
