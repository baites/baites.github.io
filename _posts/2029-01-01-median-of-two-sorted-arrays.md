---
layout: post
title: "Algorithmic magic of the median of two sorted arrays"
date: 2029-01-01 08:00:00 -0400
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
def MergeArrays(A1, S1, A2, S2, E):
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
        elif A1[i1] < A2[i2] and not E[i] or\
              A1[i1] <= A2[i2] and E[i]:
            A[i] = A1[i1]
            i1 += 1
        else:
            A[i] = A2[i2]
            i2 += 1
        i += 1
    return A

def MergeMedianTwoSortedArrays(A1, S1, A2, S2):
    A = MergeArrays(A1, S1, A2, S2, E=[False]*(S1+S2))
    return MedianSortedArray(A, S)
{% endhighlight %}

I the most important part of **MergeMedianTwoSortedArrays** is the merge step **MergeArrays** in where I made explicit using an array \\|E\\| if we use the less or the less \emph{and equal} operator to compare elements of \\|A_1\\| and \\|A_2\\| at each position of merge sorted array \\|A\\|. The use of a \\|E\\| array is unusual and in general people choose one operator throughout the process of merging \\|A\\|. However, I would like make emphasis to the fact that there are different ways of merging \\|A_1\\| and \\|A_2\\| based on the way the algorithm behaves when encounters the condition \\|A_1[i_1] == A_2[i_2]\\|. We shall see this is important property to understand when designing a more efficient algorithm.

## Algorithm edge cases in O(1)

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

## Map to the merge sorted array

Once removed the edge cases, we have two sorted arrays with an overlap between their value ranges. In this case, the seed for an efficient algorithm is rooted in using the previous merged and sorted array like the one in **MergedMedianTwoArrays** (I call it \\|A\\|) but without actually creating the array. This is because as soon you create the array the complexity can only be \\|O(S)\\|.

This can be done by using the following mapping using two integers \\|i_1 \in [0,S_1+1)\\| and \\|i_2 \in [0,S_2+1)\\| as follow

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

It is not hard to see that for some combinations of \\|(i_1, i_2)\\| (although not all of them) it is true that:

<p>%%
A[I(i_1, i_2)] = V(i_1, i_2)
%%</p>

As result of this map that I call the *merge-sort map*, knowing the proper sequence of \\|(i_1, i_2)\\| allow us to get all the values and their indexes for the merge sorted array \\|A\\| without in principle building it. In particular, the above equation is true for the sequence of integers generated by **MergeArrays** step of **MergedMedianTwoArrays**. However, this is not an option due to the fact actually running **MergeArrays** renders the algorithm again \\|O(S)\\|.

At this point I asked myself, are there any conditions for a pair of \\|(i_1, i_2)\\| such as they are part of the merge map? To answer that question I came up with the following lemma.

> **Lemma (merge-sort map)**: Given two sorted arrays \\|A_1[0..S_1-1]\\| and \\|A_2[0..S_2-1]\\| and the resulting sorted array \\|A(0..S-1)\\| with \\|S = S_1 + S_2\\| after merging them using some arbitrary \\|E\\| array, and the indexes \\|i_1, i_2\\| complying with the following conditions

<p>%%
\begin{aligned}
i_1 = 0 \text{ or } i_2 = S_2 &\text{ or } A_1[i_1-1] \leq A_2[i_2] \\
i_1 = S1 \text{ or } i_2 = 0 &\text{ or } A_2[i_2-1] \leq A_1[i_1]
\end{aligned}
%%</p>

> then it is true that \\|A[I(i_1, i_2)] = V(i_1, i_2)\\|.

## Draft the proof of the merge map lemma

I will just draft the proof in this blog. I recommend to fill up the details if interested.

First let me show you that these conditions are an invariant of the **MergeArrays** algorithm for an arbitrary choice of \\|E\\|, meaning that all the pair of indexes generated algorithm will comply with lemma conditions. The demonstration can be done by induction:

1. By definition the condition is true for \\|i_1 = i_2 = 0\\|.
2. Assuming \\|i_1 = S_1\\| and \\|i_2 < S_2\\| the algorithm updates \\|i_2 \leftarrow i_2 + 1\\|. As result we have two possible cases that keep invariant the lemma conditions after the update:
    * either \\|(i_2 + 1) = S2\\|
    * or \\|A_1[i_1-1] \leq A_2[i_2] \leq A_2[(i_2+1)]\\| because \\|A_2\\| is sorted.

3. The same reasoning applies to the case when \\|i_1 < S_1\\| and \\|i_2 = S_2\\| for an update \\|i_1 \leftarrow i_1 + 1\\|.
4. Now if \\|i_1 < S_1\\| and \\|i_2 < S_2\\| then the algorithm can make two possible updates:
    * if \\|A_1[i_1] < A_2[i_2]\\| for \\|E[i] = \text{false}\\| or \\|A_1[i_1] <= A_2[i_2]\\| for \\|E[i] = \text{true}\\| resulting in the following update \\|i_1 \leftarrow i_1 + 1\\| maintains the lemma conditions invariant:
        * \\|A_1[(i_1+1)-1] \leq A_2[i_2]\\| that covers both cases for the value of \\|E[i]\\| and
        * \\|A_2[i_2-1] \leq A_1[i_1] \leq A_1[(i_1+1)]\\| because \\|A_2\\| is sorted.
    * a similar reasoning applies to the case of having \\|A_1[i_1] \geq A_2[i_2]\\| for \\|E[i] = \text{false}\\| or \\|A_1[i_1] > A_2[i_2]\\| for \\|E[i] = \text{true}\\| that produces the update \\|i_2 \leftarrow i_2 + 1\\|.

Now, I need to prove you that any pair of indexes following the lemma conditions has to be one of those generated by **MergeArrays** algorithm using some choice of \\|E\\|. I can show this backtracking **MergeArray** algorithm when having as inputs \\|A_1, A_2\\| and initial index values \\|i_1, i_2\\| that obey the lemma conditions.

1. If \\|i_1 = 0\\| or \\|i_2 = 0\\| no condition is checked by **MergeArrays** so \\|E=[]\\|.
2. If \\|i_1 = 0\\| and \\|i_2 > 0\\| the index values before the **MergeArrays** update were \\|i_1 = 0\\| and \\|i_2 = i_2-1\\|. Now if the value of \\|A_1[0] = A_2[i_2-1]\\| implies \\|E[i_2-1] = \text{false}\\| because the second index was updated. It is easy to verify that the new value of \\|(i_2-1)\\| obeys the second condition of the lemma necessary condition if indexes were generated by **MergeArrays**:
    * either \\|(i_2-1) = 0\\|
    * or \\|A_2[(i_2-1)-1)] \leq A_2[i_2-1] \leq A_1[0]\\| because \\|A_2\\| is sorted and \\|i_2 > 0\\| complies with the second lemma condition

3. The complementary reasoning follows in case of \\|i_1 > 0\\| and \\|i_2 = 0\\|. The only difference is in this case of \\|A_1[i_1-1] = A_2[0]\\| then \\|E[i_1-1] = \text{true}\\| because the first index was updated.
4. If both \\|i_1 > 0\\| and \\|i_2 > 0\\| then:
    * if \\|A_2[i_2-1] < A_1[i_1-1]\\| then the index value before the update were \\|i_1 = (i_1-1)\\| and \\|i2 = i2\\| because it is the only way keep the lemma condition invariant:
        * \\|A_1[(i_1-1)-1] \leq A_1[(i_1-1)] \leq A_[i_2]\\| because \\|A_1\\| is sorted,
        * \\|A_2[i_2-1] < A_1[(i_1-1)]\\| by assumption
        * if \\|A_1[i_1-1] == A_2[i_2]\\| implies \\|E[i_1+i_2-1] = \text{true}\\| because the first index was updated.
    * Similar reasoning for the condition \\|A_1[i_1-1] < A_1[i_2-1]\\| implies that values before the update were \\|i_1 = i_1\\| and \\|i2 = (i2-1)\\|. However, in this case if \\|A_1[i_1] == A_2[i_2-1]\\| implies \\|E[i_1+i_2-1] = \text{false}\\| because the second index is updated.
    * If \\|A_2[i_2-1] = A_1[i_1-1]\\| you can choose either the first or the second index as the one that was updated. You can always choose to be the first index for example and therefore if \\|A_1[i_1-1] == A_2[i_2]\\| implies \\|E[i_1+i_2-1] = \text{true}\\|.
5. For those elements of \\|E\\| we do need to make any choice, so by default we can set it to be false.

In this process we can derive the values of the array \\|E\\| so that **MergeArrays** produces a merge sorted array up to the original indices \\|i_1, i_2\\|. Therefore the condition of the lemma are also sufficient to determine if are part of the merge sorted map.

## Merge-sort map and the median of two arrays

From the previous lemma we can derive the following corollary that allow us to locate the median of two sorted arrays in a particular case.

> **Corollary**: Given two sorted arrays \\|A_1[0..S_1-1]\\| and \\|A_2[0..S_2-1]\\| and the resulting sorted array after merging them \\|A(0..S-1)\\| so that \\|S = S_1 + S_2\\| is odd, and the indexes \\|m_1, m_2\\| with following conditions

<p>%%
\begin{aligned}
m_1 + m_2 &= \lfloor S/2 \rfloor \\
m_1 = 0 \text{ or } m_2 = S_2 &\text{ or } A_1[m_1-1] \leq A_2[m_2] \\
m_1 = S1 \text{ or } m_2 = 0 &\text{ or } A_2[m_2-1] \leq A_1[m_1]
\end{aligned}
%%</p>

> then the median of \\|A\\| is \\|V(m_1, m_2)\\| meaning \\|A[\lfloor S/2 \rfloor] = V(m_1, m_2)\\|

The question now is how do we find those \\|m_1\\| and \\|m_2\\|.

Any candidate pair of indices \\|i_1, i_2\\| to be pointing to the median belongs some intervals \\|i_1 \in [l_1, r_1)\\| and \\|i_2 \in [l_2, r_2)\\|. For example, initially the intervals are trivially \\|i_1 \in [0, S_1)\\| and \\|i_2 \in [0, S_2)\\|. For the pair to be a candidate it should be also true that \\|i_1 + i_2 = m\\| where \\|m = \lfloor S/2 \rfloor\\|. Therefore if for example \\|i_1 \in [l_1, r_1)\\| the first corollary condition implies also that \\|i_2 \in [\max\lbrace 0, m-r_1+1\rbrace, m-l_1)\\|. But then \\|i_2\\| belong the intersection of two intervals or \\|i_2 \in [\max\lbrace 0, m-r_1+1\rbrace, m-l_1) \cap [l_2, r_2) = [l, r)\\| where

<p>%%
\begin{aligned}
l &= \max\left\lbrace\max\lbrace 0, m-r_1+1\rbrace, l_2\right\rbrace \\
r &= \min\left\lbrace m-l_1, r_2\right\rbrace
\end{aligned}
%%</p>

Therefore the interval \\|[l, r)\\| represent all the possible candidate solutions for \\|i_2\\| and therefore also for the whole problem because \\|i_1 = m - m_2\\|. I can get then a candidate solution by bisecting \\|[l, r)\\| such as \\|i_2 = (l+r)/2\\|. Using this candidate solution and updating the \\|i_2\\| interval so \\|l_2 = l\\| and \\|r_2 = r\\| we have then the following three possibilities:

1. If the candidates failed the second condition of the lemma \\|i_1 > 0 \text{ and } i_2 < S_2 \text{ and } A_1[i_1-1] > A_2[i_2]\\| then we know that the values for \\|A_1\\| or \\|A_2\\| have to at least decrease or increase, respectively. Because both arrays are sorted, this means that the indexes pointing to the median has to be between the following ranges \\|m_1 \in [l , i_1+1)\\| and \\|m_2 \in [i_2, r_2)\\|. However, we already know that the initial combination \\|m_1 = i_1\\| and \\|m_2 = i_2\\| is not solution (it fails the second condition) therefore \\|m_1 < i_1\\| or \\|m_2 > i_2\\|. Now it is easy to see the combinations \\|m_1 = i_1\\| and \\|m_2 = i_2 + 1\\| or \\|m_1 = i_1+1\\| and \\|m_2 = i_2\\| are excluded because in both cases \\|m_1 + m_2 = i_1 + i_2 + 1 = 1\\| (failing the first condition). As result, we can derive a tighter intervals for the indexes pointing to the median \\|m_1 \in [l_1 , i_1)\\| and \\|m_2 \in [i_2+1, r_2)\\|.
2. If the candidates does not failed the second condition of the lemma, but it does third one \\|i_1 < S_1 \text{ and } i_2 > 0 \text{ and } A_2[i_2-1] > A_1[i_1]\\|. Following the same reasoning as above it is not hard to see that the indexes pointing to the median has to belong to the following intervals \\|m_1 \in [i_1+1 , r_1)\\| and \\|m_2 \in [l_2, i_2)\\|.
3. All the conditions are met therefore the median of two arrays is \\|V(m_1, m_2)\\|.

In summary the algorithm then looks like this:

{% highlight python %}
def FindMedianHelper(A1, S1, A2, S2):
     """Help to find the median between arrays."""

     # Array size
     S = S1 + S2
     m = S//2
     l1 = 0
     r1 = S1+1
     l2 = 0
     r2 = S2+1

     # Binary search
     while 1:
         l = max(m-r1+1,l2)
         r = min(m-l1+1,r2)
         m2 = (l+r)//2
         m1 = m-m2
         if m1 > 0 and m2 < S2 and A1[m1-1] > A2[m2]:
            r1 = m1
            l2 = m2+1
         elif m2 > 0 and m1 < S1 and A2[m2-1] > A1[m1]:
             l1 = m1+1
             r2 = m2
         else:
             break
     if m1 < S1 and m2 < S2:
         median1 = min(A1[m1],A2[m2])
     elif m2 == S2:
         median1 = A1[m1]
     else:
         median1 = A2[m2]
     if S%2 == 1:
         return median1
    # ... extension for even size ...

def MedianSortedArrays(self, A1, A2):
    """
    #    :type A1: List[int]
    #    :type A2: List[int]
    #    :rtype: float
    #    """
    S1 = len(A1)
    S2 = len(A2)
    S = S1 + S2
    edge = IsEdgeCase(A1, S1, A2, S2)
    if edge is not None:
        return float(edge)
    return FindMedianHelper(A1, S1, A2, S2)


{% endhighlight %}


### References

[^1]: [LeetCode](https://leetcode.com/)
[^2]: [Wikipedia: Median](https://en.wikipedia.org/wiki/Median)
[^3]: [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/)
[^4]: [Wikipedia: Merge sort](https://en.wikipedia.org/wiki/Merge_sort)
