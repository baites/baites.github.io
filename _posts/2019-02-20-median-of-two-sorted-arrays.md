---
layout: post
title: "Algorithmic magic of the median of two sorted arrays"
date: 2019-02-20 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

## Early draft soon to be updated!

## Here I go again

It being a while since my last post. I stopped blogging for a while because of some personal issues I need to resolve. However, these are technical blogs that are not meant to be mass produced. I write them with the intention of practicing my writing, get some bragging rights about my creative and knowledge (or lack of them), and more important because I enjoy it.

## Formalizing algorithms

I decided I needed to formalize my knowledge of algorithms. Although I have worked with them all my life, I never was *classically train* on them and I decided it was time for me to do so.

Although I am trying several things in this process that I might blog later in the future, the most important thing is to practice algorithms. I started looking at LeetCode[^1] for practicing algorithms and this blog is about the first **hard** problem I solved from that site.

I have not read the solution yet, although I believe it can be find on the site. I am giving you my word that I only look for the definition of the median of an array that I will discussed. Once I am done posting the blog, I will read about other solutions or discuss it with people deep in algorithmic games. I will update the post later doing some comparison between solutions.

## Median of one and two arrays

Before going to the specific problem we need to define what is the median of an array.

> **Definition:** Given an sorted array \\|A[0..S-1]\\| where \\|S\\| is the array size its median is defined as:
<p>%%
MedianSortedArray(A) = \begin{cases}
A[m] & \text{if S is odd} \\
\frac{1}{2} \lparen A[m] + A[m - 1] \rparen  & \text{otherwise}
\end{cases}
%%</p>
>where \\|m = \lfloor S/2 \rfloor \\| is the index pointing to the **middle** of the array[^2].

It is easy to see that this definition implies the following constant run time algorithm or \\|O(1)\\|:

{% highlight python %}
def MedianSortedArray(A, S):
    m = S // 2
    if S % 2:
      return A[m]
    return 0.5*(A[m]+A[m-1])
{% endhighlight %}

However, if the array is not assorted a naive solution of the problem is in python for example:
{% highlight python %}
def MedianOneArray(A, S):
    A.sort()
    return MedianSortedArray(A, S)
{% endhighlight %}
where its runtime is \\|O(S \log S)\\| where all of it comes from the need to sort the array first and \\|O(1)\\| in memory if we allow in-place sorting.

This algorithm can be easily generalize to the media of two arrays as follow
{% highlight python %}
def MedianTwoArrays(A1, S1, A2, S2):
    A = A1 + A2
    S = S1 + S2
    return MedianOneArray(A, S)
{% endhighlight %}
where \\|A_1 + A_2\\| in python represent the concatenation of the two arrays. The runtime complexity stays the same as before (with the caveat \\|S = S1 + S2\\|) however, the algorithm needs \\|O(S)\\| of memory to hold the concatenated array \\|A\\|.

## Median of two sorted arrays

> **Problem:** There are two sorted arrays \\|A_1[0..S_1-1]\\| and \\|A_2[0..S_2-1]\\| of size \\|S_1\\| and \\|S_2\\| respectively. Find the median of the two sorted arrays with a time complexity \\|O(\log(S))\\| where \\|S = S_1 + S_2\\| and a constant space complexity. You may assume \\|A_1\\| and \\|A_2\\| cannot be both empty.[^3]

Once you recover from the feeling this is not possible, it is easy to see you can improve upon the naive but general purpose **MedianTwoArrays** to a solution with a time and space complexity of \\|O(S)\\| in the case the arrays are already sorted. The trick is to reuse the *merge* step of the **MergeSort** algorithm[^4] to merge two sorted array in a third one and then call **MedianSortedArray**.

{% highlight python %}
def MergeMedianTwoSortedArrays(self, A1, S1, A2, S2):
    S = S1 + S2
    A = [0]*S
    i1 = 0; i2 = 0; i = 0
    while i1 < S1 or i2 < S2:
        if i1 == S1:
            A[i] = A2[i2]
            i2 += 1
        elif i2 == S2:
            A[i] = A1[i1]
            i1 += 1
        elif A1[i1] < A2[i2]:
            A[i] = A1[i1]
            i1 += 1
        else:
            A[i] = A2[i2]
            i2 += 1
        i += 1
    return MedianSortedArray(A, S)
{% endhighlight %}


## An efficient algorithm

### Edge cases

Let me start discussing all the edge cases that can be solved as \\|O(1)\\| in both time and space:

1. One of the two arrays is empty: in this case the problem becomes to find the median of the other non-empty and sorted array.

2. Array value range do not overlap when \\|A_1[S_1-1] < A_2[0]\\| or \\|A_2[S_2-1] < A_1[0]\\|. Within this case there are the following alternatives:

    1. For \\|S\\| odd the median is either close to the end one of the array, or alternative close to the begin of the other array.
    2. For \\|S\\| even both values to compute the median are either in the one of the two arrays, or exactly at the begin of one of the arrays and the end of the other.

In this case it is easy to read the code. This particular function is implemented such as return a **None** if the array are not an edge case.

{% highlight python %}
def IsEdgeCase(A1, S1, A2, S2):
    S = S1 + S2
    m = S//2

    # E1: One empty array
    if S1 == 0:
        return MedianSortedArray(A2, S2)
    if S2 == 0:
        return MedianSortedArray(A1, S1)

    # E2: No overlapping arrays
    if A1[-1] < A2[0]:
        #E2.1: S is odd
        if S % 2:
            if S1 > m:
                return A1[m]
            else:
                return A2[m-S1]
        #E2.2: S is even
        else:
            if S1 > m:
                return 0.5*(A1[m]+A1[m-1])
            elif m > S1:
                return 0.5*(A2[m-S1]+A2[m-1-S1])
            else:
                return 0.5*(A2[0]+A1[-1])
    # E2: Complementary case for no overlapping arrays
    if A2[-1] < A1[0]:
        #E2.1: S is odd
        if S % 2:
            if S2 > m:
                return A2[m]
            else:
                return A1[m-S2]
        #E2.2: S is even
        else:
            if S2 > m:
                return 0.5*(A2[m]+A2[m-1])
            elif m > S2:
                return 0.5*(A1[m-S2]+A1[m-1-S2])
            else:
                return 0.5*(A1[0]+A2[-1])
    return None
{% endhighlight %}

### Map to the merged array

Once removed the edge cases, we have two sorted arrays with an overlap between their value ranges. In this case, the seed for an efficient algorithm is rooted in using the previous merged and sorted array like the one in **MergedMedianTwoArrays** (I call it \\|A\\|) but without actually creating the array. This is because as soon you create the array the complexity can only be \\|O(S)\\|.

This can be done by using the following mapping using two integers \\|i_1 \in [0,S_1+1)\\| and \\|i_2 \in [0,S_2+1)\\| as show next

<p>%%
\begin{aligned}
V(i_1, i_2) &=  \begin{cases}
\min\{A_1[i_1], A_2[i_2]\} & m_1 < S_1 \text{ and } m_2 < S_2 \\
A_1[i_1]                   & m_2 == S_2 \\
A_2[i_2]                   & \text{otherwise}
\end{cases} \\
I(i_1, i_2) &= i_1 + i_2
\end{aligned}
%%</p>

It is not hard to see that for some combinations of \\|\lbrace(i_1, i_2)\rbrace\\| (although not all of them) it is true that:

<p>%%
A[I(i_1, i_2)] = V(i_1, i_2)
%%</p>

As result of this map that I call the *merge map*, knowing the proper sequence of \\|\lbrace(i_1, i_2)\rbrace\\| allow us to get all the values and their indexes for the merge sorted array \\|A\\| without in principle building it. In particular, the above equation is true for the sequence of integers generated by the algorithm **MergeMedianTwoSortedArrays** when running the merge step. However, this is not an option due to the fact running the merge step renders the algorithm again \\|O(S)\\|.

Now, you might not need to know all the possible values for the indexes, but only those \\|i^{\ast}_1, i^{\ast}_2\\| that give us the median of the array \\|A\\| (assuming for now that \\|S\\| is odd). The question is what are those conditions?

### Condition to find the median in merge map

> **Lemma**: Given two sorted arrays \\|A_1[0..S_1-1]\\| and \\|A_2[0..S_2-1]\\| and the resulting sorted merge between them \\|A(0..S-1)\\| so that \\|S = S_1 + S_2\\| is odd, and the indexes \\|i^{\ast}_1, i^{\ast}_2\\| with following conditions

<p>%%
\begin{aligned}
i^{\ast}_1 + i^{\ast}_2 &= \lfloor S/2 \rfloor \\
A_1[i^{\ast}_1-1] &\leq A_2[i^{\ast}_2] \text{ apply if } i^{\ast}_1 > 0 \text{ and } i^{\ast}_2 < S_2 \\
A_2[i^{\ast}_2-1] &\leq A_1[i^{\ast}_1] \text{ apply if } i^{\ast}_2 > 0 \text{ and } i^{\ast}_1 < S_1
\end{aligned}
%%</p>

> then the median of \\|A\\| is \\|V(i^{\ast}_1, i^{\ast}_2)\\| meaning \\|A[\lfloor S/2 \rfloor] = V(i^{\ast}_1, i^{\ast}_2)\\|

### References

[^1]: [LeetCode](https://leetcode.com/)
[^2]: [Wikipedia: Median](https://en.wikipedia.org/wiki/Median)
[^3]: [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/)
[^4]: [Wikipedia: Merge sort](https://en.wikipedia.org/wiki/Merge_sort)
