---
layout: post
title: String hashing and palindromes
date: 2030-01-15 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

* TOC
{:toc}

## Introduction

This blog started after I came up with a way of using string hashing to solve the Longest palindromic substring problem[^1] from leetcode[^2]. I studied the use of hashing to detect palindrome because I did not see any reference in any of my usual books about algorithms. However, eventually, I found out that identifying palindromic strings with hashing is a relatively known tool used in competitive coding, as I will be referring throughout this post.

In this blog post, I discuss how to hash string with polyhash, its properties, and its relationship with palindromes. I will also give the necessary steps to solve the following problem as an example of the power of this tool:

* Longest palindromic substring (a medium-difficult problem from leetcode[^2]).
* Shortest palindrome (a hard-difficult problem from leetcode[^3]).
* Palindrome degree (a codeforces' problem with difficulty x2200[^4])

I want to be sure we are on the same page here, so let me define what a palindrome or a palindromic string is.

> **Definitions**: For a string \\|S\\| of length \\|L\\|, I define its **reverse string** to the string \\|R\\| of the same length such as \\|R[i] = S[L-i-1]\\|. A string \\|S\\| is **a palindrome** if it is equal to its reverse string or \\|S = R\\|.

I this post, I am enumerating the elements of a string using a [zero-based numbering system](https://en.wikipedia.org/wiki/Zero-based_numbering).

## Hashing strings with polyhash

### Polyhash definition

Let me start with polyhash shown below.

> **Definition:** Given a string \\|S\\| of length \\|L\\|, the polyhash \\|H(S)\\| of that string is give by
>
><p>%%
H_S = \left(\sum^{L-1}_{i=0} S[i] x^{i} \right) \text{mod } p
%%</p>
>
>where \\|p\\| is a prime (and usually large) number, and \\|x\\| some integer \\|x \in [1, p-1]\\|.

It is trivial to see that the polyhash values for identical strings are the same. The question is then what happens for two distinct strings. The following lemma answer this question by saying that the probability of two different strings having the same hash value is very low[^5].

> **Lemma:** For any two string \\|S\\| and \\|Q\\| of length at most \\|L+1\\|, and  a polyhash created by selecting at random a \\|x \in [1,p-1]\\| for some (usually large) prime \\|p\\|, then the probability of both string having the same hash is bound by
>
><p>%%
\text{Prob}[H_{S} = H_{Q}] \leq \frac{L}{p}
%%</p>

Hashing and palindrome can be related as follow.

> **Corollary:** For a non-palindromic string \\|S\\| of length \\|L\\| and its reverse string \\|R\\|, plus a polyhash as define in the previous lemma, then the probability of both string having the same hash is bound by
>
><p>%%
\text{Prob}[H_{S} = H_{R}] \leq \frac{L}{p}
%%</p>

This result shows that, in principle, we can detect a palindrome \\|S\\| by comparing polyhash values of itself and its reverse \\|R\\| with arbitrarily high precision depending on the hash parameters.

### Forward and backward hashes

I just showed you that it is possible to detect palindrome using hashing. The remaining issue is how to extend this check to a substring of \\|S\\| efficiently.

A first step to answer these questions requires the definition of two types of hash functions that I arbitrarily named *forward* and *backward* hashes.

> **Definition:** Given a string \\|S\\| I define its forward hashes \\|F_S[n]\\| as the hash values of the \\|n\\|-length prefix of \\|S\\| or  
>
><p>%%
F_S[n] = \left(\sum^{n-1}_{i=0} S[i] x^{i} \right) \text{mod } p
%%</p>
>
> where I choose for \\|n = 0\\| the following hash value \\|F_S[0] = 0\\|.

It is easy to see that the hash value of a string \\|S\\| is \\|F_S[L]\\|.

> **Definition:** Given a string \\|S\\| I define its backward hashes \\|B_S[n]\\| as the hash values of the \\|n\\|-size suffixes of \\|S\\| or  
>
><p>%%
B_S[n] = \left(\sum^{L-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
%%</p>
>
> where I choose for \\|n = 0\\| the following hash value \\|B_S[0] = 0\\|.

In a similar way as before, the hash value for string \\|S\\| is \\|B_S[L]\\|.

Now if a string \\|S\\| is palindrome then its hash value \\|F_S[L]\\| is equal to the hash value of its reverse string \\|F_R[L]\\| that is also equal to \\|B_R[L]\\|.
Therefore, for a palindrome \\|S\\| is true that \\|F_S[L] = B_R[L]\\|.

More importantly, if \\|S\\| contains a palindromic prefix of size \\|n\\|, then it is easy to see that \\|F_S[n] = B_R[n]\\|, that is the \\|n\\|-th forward hash of the string has to be the same as the \\|n\\|-th backward hash of the reverse string. The following figure illustrates this point.

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-palindromic-string.svg" width="80%" />
</p>
<p>Detecting palindromic prefix using forward and backward hashes in string S and its reverse R. I use number representing character ordinals instead of the actual characters.</p>
</center>

Conversely, the probability for a string of having non-palindromic prefix of size \\|n\\| such as \\|F_S[n] = B_R[n]\\| cannot be higher than \\|n/p\\| based on the corollary of the previous section.

### Computing forward and backward hashes

So far, I found a way of detecting any palindromic prefixes using forward and backward hashing. So, in this section, I will concentrate on how to compute those hashes efficiently.

Let me start with a proposition that establishes a recurrence between forward hashes of different sizes.

> **Proposition (A):** The forward hashes for the string \\|S\\| are related by the following recurrence:
>
><p>%%
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

**Note**: In this proof, I use all the properties of the [modular arithmetic](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic).

> **Proposition (B):** The backwards hashes for the reverse string \\|R\\| of \\|S\\| are related by the following recurrence:
>
><p>%%
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

It is easy to generalize the notion of the forward hash of a substring \\|S[m..n]\\| as the hash value of the substring[^5].

> **Definition:** Given a substring \\|S[m..n]\\| I define its forward hash \\|F_S[m..n]\\| as the hash value given by
>
><p>%%
F_S[m..n] = H(S[m..n]) = \left(\sum^{n-1}_{i=m} S[i] x^{i-m} \right) \text{mod } p
%%</p>

The same can be done for the backward hash of a substring \\|S[m..n]\\| as defined below.

> **Definition:** Given a substring \\|S[m..n]\\| I define its backward hash \\|B_S[m..n]\\| as the hash value given by
>
><p>%%
B_S[m..n] = H(S[L-n..L-m]) = \left(\sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
%%</p>

Under these definitions I get that \\|F_S[0..n] = F_S[n]\\| and \\|B_S[0..n] = B_S[n]\\|.

> **Proposition:** For a substring \\|S[m..n]\\| we have
> * if it is a palindrome then
><p>%%
>F_S[m..n] = B_R[m..n]
>%%</p>
> * otherwise
><p>%%
>\text{Prob}(F_S[m..n] = B_R[m..n]) \leq (n-m)/p
>%%</p>

The proof of this proposition is done by combining these definitions of forward and backward substring hashes, the condition for a substring to be a palindrome, and the main polyhash lemma, see also next figure.

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-palindromic-substring.svg" width="50%" />
</p>
<p>Detecting palindromic substring using forward and backward hashes of substrings of S and R.</p>
</center>

### Computing forward and backward hashes for substrings

In this section, I show a way to compute the substring forward \\|F_S[m..n]\\| and backward \\|B_S[m..n]\\| hashes in constant time after precomputing the forward and backward hashes for the whole string. For the content in this section, I took a lot of inspiration from this excellent blog post in cp-algorithms[^6].

In the case of the forward hashes of a substring \\|F_S[m..n]\\|, this computation is possible by first precomputing the full-forward hashes of a string \\|F_S[n]\\| and using the following relationship[^6].

<p>%%
\begin{aligned}
F_S[n] - F_S[m] &= \sum^{n-1}_{i=0} S[i] x^{i} - \sum^{m-1}_{i=0} S[i] x^{i} = \sum^{n-1}_{i=m} S[i] x^{i} \\
                &= x^m \sum^{n-1}_{i=m} S[i] x^{i-m} \\
                &= x^m F_S[m..n]
\end{aligned}
%%</p>

In the case of the backward hashes of a substring \\|B_S[m..n]\\|, this computation is possible by first precomputing the full backward hashes of a string \\|B_S[n]\\| and using the following relationship.

<p>%%
\begin{aligned}
B_S[n] - x^{n-m} B_S[m] &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - x^{n-m} \sum^{L-1}_{i=L-m} S[i] x^{i-L+m} \\
                        &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - \sum^{L-1}_{i=L-m} S[i] x^{i-L+n} \\
                        &= \sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \\
                        &= B_S[m..n]
\end{aligned}
%%</p>

In the previous section, I showed that for a palindromic substring, the forward hash value of the substring must be the same as the backward hash value for a substring in the reverse string or \\|F_S[m..n] = B_R[m..n]\\|. This statement is equivalent to say \\|x^mF_S[m..n] \equiv x^mB_R[m..n] (\text{mod }p)\\|, resulting in the following alternative proposition.

> **Proposition (C):** For a substring \\|S[m..n]\\| we have that
> * if it is a palindrome then
><p>%%
>F_S[n] - F_S[m] \equiv x^m B_R[n] - x^n B_R[m] (\text{mod }p)
>%%</p>
> * otherwise
><p>%%
>\text{Prob}[F_S[n] - F_S[m] \equiv x^m B_R[n] - x^n B_R[m] (\text{mod }p)] \leq (n-m)/p
>%%</p>

## Practical applications

### Longest palindromic substring

Let's start with the problem definition.

> **Problem:** Given a string \\|S\\|, find the longest palindromic substring in s. You may assume that the maximum length of \\|\|S\|\\| is 1000.[^2]

A simple solution to the problem has a time complexity of \\|O(L^3)\\| as it is explained [LeetCode](https://leetcode.com/problems/longest-palindromic-substring/solution/). This same site also shows several solutions in \\|O(L^2)\\| using dynamic programming or expand around center approach. There is also another solution \\|O(L)\\| known as the Manacher's Algorithm[^6].

It is easy to come up with a solution in time \\|O(L^2)\\| for most of the cases.

* Select a random value of \\|x \in [1, p-1]\\| for some large prime \\|p\\|.
* Precompute the values of \\|F_S[n]\\| and \\|B_R[n]\\| in arrays using proposition A and B.
* Scan all possible substring starting from longest to the smallest ones and do:
  * Check if the substring is a candidate to be a palindrome using proposition C.
  * If it is a candidate, verify if the substring is a palindrome.
    * If it is a palindrome, return the substring.
    * Otherwise, keep scanning for other substring candidates.

You can find my version of the algorithm I submitted and pass [leetcode graduation system](https://github.com/baites/examples/blob/master/coding/leetcode/longest_palindromic_substring_hashing_v5.py).

### Shortest palindrome

In this case, the problem is to create the shortest possible palindrome from an initial string.

> **Problem:** Given a string \\|S\\|, you are allowed to convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.[^3]

One way to solve this problem is by locating the longest palindromic prefix of the input string. Then create the reverse of the input string and remove the longest palindromic suffix (that is the same as the longest palindromic prefix of the input string). Concatenate this modified reverse string with the original string; see the figure below.

It is easy to formulate a \\|O(L)\\| solution to this problem with hashing.

* If the string is only one character, just return that character.
* Select a random value of \\|x \in [1, p-1]\\| for some large prime \\|p\\|.
* Compute recursively the values of \\|F_S\\| and \\|B_R\\| using proposition A and B.
  * In this case, you do not need to save all the values in an array.
  * Every time you detect a collision (\\|F_S = B_R\\|), save the location in a stack.
* While the stack is not empty
  * Pop a collision location from the stack
  * Check if the resulting prefix ending in the given location is palindrome.
    * If it is a palindrome, return the concatenation between the reverse string minus the palindromic plus the original string.
    * Otherwise, continue.

You can find my version of the algorithm I submitted and pass [leetcode graduation system](https://github.com/baites/examples/blob/master/coding/leetcode/shortest_palindrome.py).

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-shortest-palindromic-string.svg" width="70%" />
</p>
<p>Illustration of how to solve the shortest palindromic string problem.</p>
</center>

### Palindrome degree

I will leave this problem as homework. If you get stuck, you can take a look at this [effectively five-line C++ submission in codeforces](https://codeforces.com/contest/7/submission/3686936). It should take you no time to read the code with the information provided by this blog.

## Choosing hash parameters

In practice, I do not randomly choose the value of the hash. Instead, I set its value to be \\|x = 31\\| because of alphabet size, and \\|p = 10^9+9\\| that is a [prime number](https://primes.utm.edu/curios/page.php?short=1000000009). I use these choices following a recommendation from the cp-algorithms post[^6].

On some occasions, people working with language with fix-sized integer choose to use the integer overflow as an equivalent of modular arithmetic with \\|p = 10^{64}\\|. However, this is not recommended for competitive coding. People designing problems know how to create colliding strings for any value of \\|x \in [1, p-1]\\|! In particular, this Zlobober's blog shows how to break the solution to the palindrome degree problem based on hashing if you avoid modular arithmetic[^8].

## References

[^1]: [Longest palindromic substring](https://leetcode.com/problems/longest-palindromic-substring/)
[^2]: [LeetCode](https://leetcode.com/).
[^3]: [Shortest palindrome](https://leetcode.com/problems/shortest-palindrome/).
[^4]: [Palindrome Degree](https://codeforces.com/contest/7/problem/D).
[^5]: [Data structure's Coursera course](https://www.coursera.org/learn/data-structures/lecture/KKYUc/hashing-strings).
[^6]: [CP-Algorithms: String Hashing](https://cp-algorithms.com/string/string-hashing.html)
[^7]: [Manacher's Algorithm](https://www.hackerrank.com/topics/manachers-algorithm).
[^8]: [Anti-hash test](https://codeforces.com/blog/entry/4898)
