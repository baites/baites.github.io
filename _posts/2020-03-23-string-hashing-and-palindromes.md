---
layout: post
title: String hashing and palindromes
date: 2020-03-23 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

* TOC
{:toc}

# Introduction

This blog started after I came up with a way of using string hashing to solve the Longest palindromic substring problem[^1] from leetcode[^2]. I decided to document the use of hashing to detect palindromes because I did not find much information in my usual books about algorithms. However, eventually, I found out that identifying palindromic strings with hashing is a relatively well known tool used in competitive coding.

In this blog post, I discuss how to hash string with polyhash, its properties, and its relationship with palindromes. I examples of problems that can be solved with this power of this tool:

* Longest palindromic substring (a medium-difficult problem from leetcode[^2]).
* Shortest palindrome (a hard-difficult problem from leetcode[^3]).
* Palindrome degree (a codeforces' problem with difficulty x2200[^4])

I want to be sure that we are all on the same page here, so let me define what a palindrome or a palindromic string is.

{% include statement/definition %}
For a string $S$ of length $L$, I define its **reverse string** to the string $R$ of the same length such as $R[i] = S[L-i-1]$. A string $S$ is **a palindrome** if it is equal to its reverse string or $S = R$.
{% include statement/end %}

**Note**: I am enumerating the elements of a string using a [zero-based numbering system](https://en.wikipedia.org/wiki/Zero-based_numbering).

# Hashing strings with polyhash

## Polyhash definition

Let me start with the definition of polyhash.

{% include statement/definition %}
Given a string $S$ of length $L$, the polyhash $H(S)$ of that string is give by

$$
H_S = \left(\sum^{L-1}_{i=0} S[i] x^{i} \right) \text{mod } p
$$

where $p$ is a (and usually large) prime number, and $x$ some integer $x \in [1, p-1]$.
{% include statement/end %}

It is trivial to see that the polyhash values for identical strings are the same. The question is then what happens for two distinct strings. The following lemma answer this question by saying that the probability of two different strings having the same hash value is very low[^5].

{% include statement/lemma %}
For any two string $S$ and $Q$ of length at most $L+1$, and  a polyhash created by selecting at random a $x \in [1,p-1]$ for some (usually large) prime $p$, then the probability of both string having the same hash is bound by

$$
\text{Prob}[H_{S} = H_{Q}] \leq \frac{L}{p}
$$
{% include statement/end %}

Hashing and palindrome can be related as follow.

{% include statement/corollary %}
For a non-palindromic string $S$ of length $L$ and its reverse string $R$, plus a polyhash as define in the previous lemma, then the probability of both string having the same hash is bound by

$$
\text{Prob}[H_{S} = H_{R}] \leq \frac{L}{p}
$$
{% include statement/end %}

This result shows that, in principle, we can detect a palindrome $S$ by comparing the hash values of itself and its reverse $R$ with arbitrarily high precision depending on the selected prime $p$.

## Forward and backward hashes

I just showed you that it is possible to detect palindrome using hashing. The remaining issue is how to extend this check to a substring of $S$.

A first step to answer this question requires the definition of two types of hash functions that I arbitrarily named *forward* and *backward* hashes.

{% include statement/definition %}
I define for string $S$ its forward hashes $F_S[n]$ as the hash values of the $n$-length prefix of $S$ or

$$
F_S[n] = \left(\sum^{n-1}_{i=0} S[i] x^{i} \right) \text{mod } p
$$

where I choose for $n = 0$ the following hash value $F_S[0] = 0$.
{% include statement/end %}

It is easy to see that the hash value of a string $S$ is $F_S[L]$.

{% include statement/definition %}
I define for string $S$ its backward hashes $B_S[n]$ as the hash values of the $n$-size suffixes of $S$ or

$$
B_S[n] = \left(\sum^{L-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
$$

where I choose for $n = 0$ the following hash value $B_S[0] = 0$.
{% include statement/end %}

In a similar way as before, the hash value for string $S$ is $B_S[L]$.

Now if a string $S$ is palindrome then its hash value $F_S[L]$ is equal to the hash value of its reverse string $F_R[L]$, that is also equal to $B_R[L]$.
Therefore, for a palindrome $S$ is true that $F_S[L] = B_R[L]$.

More importantly, if $S$ contains a palindromic prefix of size $n$, then it is easy to see that $F_S[n] = B_R[n]$, that is the $n$-th forward hash of the string has to be the same as the $n$-th backward hash of the reverse string. The following figure illustrates this point.

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-palindromic-string.svg" width="80%" />
</p>
<p>Detecting palindromic prefix using forward and backward hashes in string S and its reverse R. I use number representing character ordinals instead of the actual characters.</p>
</center>

Conversely, the probability for a string of having non-palindromic prefix of size $n$ such as $F_S[n] = B_R[n]$ cannot be higher than $n/p$ based on the corollary of the previous section.

## Computing forward and backward hashes

So far, I found a way of detecting any palindromic prefixes using forward and backward hashing. So, in this section, I will concentrate on how to compute those hashes efficiently.

Let me start with a proposition that establishes a recurrence between forward hashes of different sizes.

{% include statement/proposition name='A' %}
The forward hashes for the string $S$ are related by the following recurrence:

$$
F_S[n+1] = \left(F_S[n] + x^nS[n]\right) \text{ mod } p
$$
{% include statement/end %}

**Proof**:

$$
\begin{aligned}
F_S[n+1] &= \left(\sum^{n}_{i=0} S[i] x^i \right) \text{mod } p \\
         &= \left(\sum^{n-1}_{i=0} S[i] x^i + x^n S[n]\right) \text{mod } p \\
         &= \left(F_S[n] + x^n S[n]\right) \text{mod } p
\end{aligned}
$$

{% include statement/proposition name='B' %}
The backwards hashes for the reverse string $R$ of $S$ are related by the following recurrence:

$$
B_R[n+1] = \left(xB_R[n] + S[n]\right) \text{ mod } p
$$
{% include statement/end %}

**Proof**:

$$
\begin{aligned}
B_R[n+1] &= \left(\sum^{L-1}_{i=L-n-1} S[L-i-1] x^{i-L+n+1} \right) \text{mod } p \\
         &= \left(\sum^{L-1}_{i=L-n} S[L-i-1] x^{i-L+n+1} + S[n]\right) \text{mod } p \\
         &= \left(x\sum^{L-1}_{i=L-n} S[L-i-1] x^{i-L+n} + S[n]\right) \text{mod } p \\
         &= \left(xB_R[n] + S[n]\right) \text{ mod } p
\end{aligned}
$$

**Note**: For these proofs, I use all the properties of the [modular arithmetic](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic).

# Forward and backward hashes of a substring

## Defining forward and backward substring hashes

It is easy to generalize the notion of the forward hash but for substrings.

{% include statement/definition %}
I define its forward hash $F_S[m..n]$ as the hash value of the substring $S[m..n]$

$$
F_S[m..n] = H(S[m..n]) = \left(\sum^{n-1}_{i=m} S[i] x^{i-m} \right) \text{mod } p
$$
{% include statement/end %}

The backward hash for substrings is by analogy.

{% include statement/definition %}
I define its backward hash $B_S[m..n]$ as the hash value of the substring $S[L-n..L-m]$

$$
B_S[m..n] = H(S[L-n..L-m]) = \left(\sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \right) \text{mod } p
$$
{% include statement/end %}

These definitions are motivated so when $m = 0$ we obtain the previous forward and backward hashes, meaning $F_S[0..n] = F_S[n]$ and $B_S[0..n] = B_S[n]$.

{% include statement/proposition %}
For a substring $S[m..n]$ is a palindrome then

$$
F_S[m..n] = B_R[m..n]
$$

otherwise

$$
\text{Prob}(F_S[m..n] = B_R[m..n]) \leq (n-m)/p
$$
{% include statement/end %}

The proof of this proposition is done by combining these definitions of forward and backward substring hashes, the condition for a substring to be a palindrome, and the main polyhash lemma. The next figure shows an example for some generic palindromic substring.

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-palindromic-substring.svg" width="50%" />
</p>
<p>Detecting palindromic substring using forward and backward substring hashes of S and R.</p>
</center>

## Computing forward and backward substring hashes

Let me now show you a way to compute the forward and forward substring hashes $F_S[m..n]$ and $B_S[m..n]$ in constant time after precomputing the forward and backward hashes for the whole string. For the content in this section, I took a lot of inspiration from this excellent blog post in cp-algorithms[^6].

**Note**: At this moment I am discussing the value of $B_S[m..n]$ for a generic string $S$ and not necessarily its reverse $R$. I discuss the use of the value $B_R[m..n]$ (for the reverse of the string $S$) in the last proposition in this section.

In the case of the forward substring hashes $F_S[m..n]$, this computation is possible by first precomputing the full-forward hashes of a string $F_S[n]$ and using the following relationship[^6].

$$
\begin{aligned}
F_S[n] - F_S[m] &= \sum^{n-1}_{i=0} S[i] x^{i} - \sum^{m-1}_{i=0} S[i] x^{i} = \sum^{n-1}_{i=m} S[i] x^{i} \\
                &= x^m \sum^{n-1}_{i=m} S[i] x^{i-m} \\
                &= x^m F_S[m..n]
\end{aligned}
$$

In the case of the backward substring hashes $B_S[m..n]$, this computation is possible by first precomputing the full backward hashes of a string $B_S[n]$ and using the following relationship.

$$
\begin{aligned}
B_S[n] - x^{n-m} B_S[m] &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - x^{n-m} \sum^{L-1}_{i=L-m} S[i] x^{i-L+m} \\
                        &= \sum^{L-1}_{i=L-n} S[i] x^{i-L+n} - \sum^{L-1}_{i=L-m} S[i] x^{i-L+n} \\
                        &= \sum^{L-m-1}_{i=L-n} S[i] x^{i-L+n} \\
                        &= B_S[m..n]
\end{aligned}
$$

**Note**: In the last two equations for clarity, I avoided the use of modular arithmetic notation. I will leave the reader as a homework to verify the equalities are also true after accounting for the modular arithmetic.

In the previous section, I showed that for a palindromic substring, the forward hash value of the substring must be the same as the backward hash value for a substring in the reverse string or $F_S[m..n] = B_R[m..n]$. This statement is equivalent to say $x^mF_S[m..n] \equiv x^mB_R[m..n] (\text{mod }p)$, resulting in the following alternative proposition.

{% include statement/proposition name='C' %}
If a substring $S[m..n]$ is a palindrome then

$$
F_S[n] - F_S[m] \equiv x^m B_R[n] - x^n B_R[m] (\text{mod }p)
$$

otherwise

$$
\text{Prob}[F_S[n] - F_S[m] \equiv x^m B_R[n] - x^n B_R[m] (\text{mod }p)] \leq (n-m)/p
$$
{% include statement/end %}

# Applications in algorithms

## Longest palindromic substring

Let's start with the problem definition.

{% include statement/problem %}
> Given a string $S$, find the longest palindromic substring in s. You may assume that the maximum length of $\|S\|$ is 1000.[^2]
{% include statement/end %}

A simple solution to the problem has a time complexity of $O(L^3)$ as it is explained [LeetCode](https://leetcode.com/problems/longest-palindromic-substring/solution/). This same site also shows several solutions in $O(L^2)$ using dynamic programming or expand around center approach. There is also another solution $O(L)$ known as the Manacher's Algorithm[^6].

It is easy to come up with an alternative solution in $O(L^2)$ time for most of the instances as follow:

* Select a random value of $x \in [1, p-1]$ for some large prime $p$.
* Precompute the values of $F_S[n]$ and $B_R[n]$ in arrays using proposition A and B.
* Scan all possible substring starting from longest to the smallest ones and do:
  * Check if the substring is a candidate to be a palindrome using proposition C.
  * If it is a candidate, verify if the substring is a palindrome.
    * If it is a palindrome, return the substring.
    * Otherwise, keep scanning for other substring candidates.

You can find my version of the algorithm I submitted and pass [leetcode graduation system](https://github.com/baites/examples/blob/master/coding/leetcode/longest_palindromic_substring_hashing_v5.py).

## Shortest palindrome

In this case I need to create the shortest possible palindrome from an initial string.

{% include statement/problem %}
Given a string $S$, you are allowed to convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.[^3]
{% include statement/end %}

One way to solve this problem is by locating the longest palindromic prefix of the input string. Then create the reverse of the input string and remove the longest palindromic suffix (that is the same as the longest palindromic prefix of the input string). Then concatenate modified reverse string with the original string; see the figure below.

It is easy to formulate a $O(L)$ solution to this problem with hashing.

* If the string is only one character, just return that character.
* Select a random value of $x \in [1, p-1]$ for some large prime $p$.
* Compute recursively the values of $F_S$ and $B_R$ using proposition A and B.
  * In this case, you do not need to save all the values in an array.
  * Every time you detect a collision ($F_S = B_R$), save the location in a stack.
* While the stack is not empty
  * Pop a collision location from the stack
  * Check if the resulting prefix ending in the given location is palindrome.
    * If it is a palindrome, return the concatenation between the reverse string minus the palindromic suffix with the original string.
    * Otherwise, continue.

You can find my version of the algorithm I submitted and pass [leetcode graduation system](https://github.com/baites/examples/blob/master/coding/leetcode/shortest_palindrome.py).

<center>
<p>
  <img src="{{ site.url }}/assets/images/hash-shortest-palindromic-string.svg" width="70%" />
</p>
<p>Illustration of how to solve the shortest palindromic string problem.</p>
</center>

## Palindrome degree

I will leave this problem as homework. If you get stuck, you can take a look at this [effectively five-line C++ submission in codeforces](https://codeforces.com/contest/7/submission/3686936). It should take you no time to read the code with the information provided by this blog.

# Choosing hash parameters

In practice, I do not randomly choose the value of the hash. Instead, I set its value to be $x = 31$ because of alphabet size, and $p = 10^9+9$ that is a [prime number](https://primes.utm.edu/curios/page.php?short=1000000009). I use these choices following a recommendation from the cp-algorithms post[^6].

On some occasions, people working with language with fix-sized integer choose to use the integer overflow as an equivalent of modular arithmetic with $p = 10^{64}$. However, this might not be a good idea for competitive coding. People designing problems know how to create colliding strings for any value of $x \in [1, p-1]$! In particular, this Zlobober's blog shows how to break the solution to the palindrome degree problem based on hashing if you avoid modular arithmetic[^8].

# References

[^1]: [Longest palindromic substring](https://leetcode.com/problems/longest-palindromic-substring/)
[^2]: [LeetCode](https://leetcode.com/).
[^3]: [Shortest palindrome](https://leetcode.com/problems/shortest-palindrome/).
[^4]: [Palindrome Degree](https://codeforces.com/contest/7/problem/D).
[^5]: [Data structure's Coursera course](https://www.coursera.org/learn/data-structures/lecture/KKYUc/hashing-strings).
[^6]: [CP-Algorithms: String Hashing](https://cp-algorithms.com/string/string-hashing.html)
[^7]: [Manacher's Algorithm](https://www.hackerrank.com/topics/manachers-algorithm).
[^8]: [Anti-hash test](https://codeforces.com/blog/entry/4898)
