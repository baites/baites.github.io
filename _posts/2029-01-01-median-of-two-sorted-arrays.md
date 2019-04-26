---
layout: post
title: "Algorithmic magic of the median of two sorted arrays"
date: 2029-01-01 08:00:00 -0400
author: Victor E. Bazterra, Codeforces' Mandinga
categories: algorithms algorithm-analysis
javascript:
  katex: true
---
## Early draft soon to be updated!

## Here I go again

It is a while since my last post. I stopped blogging for a while because of some personal issues I need to resolve. However, these are technical blogs that are not meant to be mass produced. I write them intending to practice my writing, also to get some bragging rights about my creative and knowledge, and more important because I enjoy it.

## Formalizing algorithms

I decided that I needed to formalize my knowledge about algorithms. Although I have worked with them all my life, I never was *classically train* on them, and therefore I decided it was time for me to do so.

The most crucial step I am taking is to practice following a competitive coding format. I started looking at LeetCode[^1] for coding questions, and this blog is about the first **hard** problem I solved from that site.

This blog was written in collaboration with Codeforces' Mandinga. We were starting sharing some of our solution to the problem and some of our approaches to prove our algorithm's correctness and time complexity. My initial attempt to do that with my solution was very messy at best. Mandinga came up with a framework that made more straightforward to understand how the algorithm works. Then we worked in defining a notation based on this framework and use it to prove the main lemma that shows that the algorithm is correct. This framework also allows us to write a code that is easy to read and derive its time complexity.

## Median of two arrays

Before going to the specific problem, let's need to define what is the median of an array.

> **Definition:** Given an sorted array \\|A[0..S-1]\\| where \\|S\\| is the array size its median is defined as:
<p>%%
\text{MedianSortedArray}(A) = \begin{cases}
A[m] & \text{if S is odd} \\
\frac{1}{2} \lparen A[m] + A[m - 1] \rparen  & \text{otherwise}
\end{cases}
%%</p>
>where \\|m = \lfloor S/2 \rfloor \\| is the index pointing to the **middle** of the array[^2].

It is easy to see that this definition implies the following constant run time algorithm or \\|O(1)\\|. For example in python you could write:

{% highlight python %}
def MedianSortedArray(A):
    S = len(A)
    return 0.5*(A[(S-1)//2] + A[S//2])
{% endhighlight %}

The median for an arbitrary array can be computed simply by sorting the array first as shown next

{% highlight python %}
def MedianOneArray(A):
    A.sort()
    return MedianSortedArray(A)
{% endhighlight %}

where its runtime is \\|O(S \log S)\\| where all of it comes from the need to sort the array first and \\|O(1)\\| in memory if we allow in-place sorting.

With this definition in place, the coding question is the following.

> **Problem:** There are two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\| of size \\|S_A\\| and \\|S_B\\| respectively. Find the median of the two sorted arrays with a time complexity \\|O(\log(S_A+S_B))\\| and in constant space complexity. You may assume \\|A\\| and \\|B\\| cannot be both empty.[^3]

It is easy to see this problem can have a linear solution \\|O(S_1 + S_2)\\| in time and space complexities by exploiting the fact both input arrays are sorted. The trick is to use the *merge* step of the **MergeSort** algorithm[^4] to merge the two sorted arrays in a third one and then call **MedianSortedArray**.

{% highlight python %}
def MergeArrays(A, B):
    SA = len(A)
    SB = len(B)
    S = SA + SB
    AB = [0]*S
    iA = 0; iA = 0; i = 0
    while iA < SA or iB < SB:
        # at the end of the first array
        if iA == SA:
            A[i] = B[iB]
            iB += 1
        # at the end of the second array
        elif iB == SB:
            A[i] = A[iA]
            iA += 1
        # if any indexes not at the end
        else:
            if A[iA] < B[iB]:
                A[i] = A[iA]
                iA += 1
            else:
                A[i] = AB[iB]
                iB += 1
        i += 1
    return AB

def MergeMedianTwoSortedArrays(A, B):
    AB = MergeArrays(A, B)
    return MedianSortedArray(AB)
{% endhighlight %}

The question is now how can we improve upon this solution.

## The merge-sort map problem

The finding the median of two sorted arrays can be thought as a particular case of a more generic problem we call the merge-sort map problem.

> **Merge-Sort Map Problem:** Given two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\|, let's define \\|AB\\| as the sorted concatenation of \\|A\\| and \\|B\\|, then find the value of the \\|n\\|-th element of \\|AB\\| for any \\|n \in [1, S_A+S_B]\\| with a sub-linear runtime and \\|O(1)\\| space complexities. It is safe to assume at least one of the arrays is not empty.

We call this problem the Merge-Sort Map problem because we would like to find a function that points to the value of the merge-sort array \\|AB\\| without explicitly building it. This is because the problem can be easily solved by merging the two sorted arrays using **MergeArrays** method as shown in the previous section. However, this renders the problem to a \\|O(S_A + S_B)\\| time and space complexity required to merge the arrays. However, if it is possible to know the value of sort-merge array in any position more efficiently, then it becomes easy to find the median of these two arrays by running **MedianSortedArray** method.

We adopt the following notation to simplify the discussion of the problem. We annotate concatenation of \\|A\\| and \\|B\\| as \\|A + B\\| and the sorted concatenation as \\|A \oplus B\\| (using this notation then \\|AB = A \oplus B\\|). We also say that these two arrays \\|A \leq B\\| if it is true that all elements of \\|A\\| are less or equal to any the element in \\|B\\|. In particular, if both arrays are already sorted, this condition can be verified in constant time simply by \\|A \leq B \equiv A[S_A-1] \leq B[0]\\|.

We also define \\|\text{Head}(A,n)\\| where \\|A\\| is an array and \\|n\\| a positive integer, as the array form by the first \\|n\\| inclusive elements of \\|A\\|. In particular, we say that \\|\text{Head}(A,0)\\| is an empty array and also that \\|A =  \text{Head}(A,n)\\| for any \\|n \geq S_A\\|.

In a complementary way, we write \\|\text{Tail}(A,n)\\| as the resulting array after removing the first \\|n\\| inclusive elements of \\|A\\| such as \\|A = \text{Head}(A,n) + \text{Tail}(A,n)\\| for any value of \\|n\\|. From this definition it should be clear that \\|A = \text{Tail}(A,0)\\| and \\|\text{Tail}(A,S_A)\\| is an empty array.

We would like to remark using this notation that if \\|A\\| is already sorted, then for any the value of \\|n\\| then \\|A = \text{Head}(A,n) \oplus \text{Tail}(A,n)\\|. Also, \\|A\\| head is always less or equal than its tail or \\|\text{Head}(A,n) \leq \text{Tail}(A,n)\\| for \\|0 < n < S_A\\|. Finally, in the case of having now two sorted arrays \\|A\\| and \\|B\\| such as \\|A \leq B\\| then sorted concatenation of both array is just a simple concatenation or \\|A \oplus B = A + B\\|.

Using this notation, a solution to the merge-sort map problem can be formulated as follow. Assume you have two integers \\|n_A\\| and \\|n_B\\| where at least one of them is not zero, and it is true that

<p>%%
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) = \text{Head}(A \oplus B, n_A + n_B) \text{ (1)}
%%</p>

then the value for the \\|n\\|-th element of the merge-sort array \\|AB\\| where \\|n = n_A + n_B\\| for the case that \\|n_A \leq S_A\\| and \\|n_B \leq S_B\\| is given by following function

<p>%%
\begin{aligned}
\text{Value}(n_A,n_B) &\doteq  \begin{cases}
A[n_A-1] & \text{if } n_B = 0 \\
B[n_B-1] & \text{if } n_A = 0 \\
\max\{A[n_A-1], B[n_B-1]\} & \text{otherwise}
\end{cases}
\end{aligned}
%%</p>

Next figure shows an example of the above condition for two arbitrary arrays. This reformulation is just equivalent to build a sort-merge array explicitly. However, we show soon this reformulation is useful to find the most efficient way of solving the problem.

{% include image file="median-two-sorted-arrays-fig-1a.svg" scale="80%" %}
<center><p>Head and tail relationships for a sort-merge array.</p></center>

The merge-sort array also has a complementary tail relationship in where for those \\|n_A\\| and \\|n_B\\| complying with the previous condition (1) we can write

<p>%%
\begin{aligned}
A \oplus B &= \left[\text{Head}(A, n_A) \oplus \text{Tail}(A, n_A)\right] \oplus \left[\text{Head}(B, n_B) \oplus \text{Tail}(B, n_B)\right] \\
           &= \left[\text{Head}(A, n_A) \oplus \text{Head}(B, n_B)\right] \oplus \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right] \\
           &= \text{Head}(A \oplus B, n_A + n_B) \oplus \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right]
\end{aligned}
%%</p>

and because \\|A \oplus B =  \text{Head}(A \oplus B, n) \oplus \text{Tail}(A \oplus B, n)\\| for any \\|n\\| it has to be true that

<p>%%
\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B) = \text{Tail}(A \oplus B, n_A + n_B) \text{ (2)}
%%</p>


## The merge-sort map lemma

As formulated, the head-tail relationships (1) and (2) presented in the previous section is not enough to help us in building a more efficient way of solving the problem. However, the following lemma provides us to find a new set of head-tail relationships that can be checked efficiently.

> **Lemma (merge-sort map)**: Given two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\| and two positive integer \\|n_A\\| and \\|n_B\\| where at least on of them is not zero, then they comply with the head-tail conditions (1) and (2) if and only if it is true that

<p>%%
\begin{aligned}
n_A = 0 \text{ or } n_B \geq S_B \text{ or } \text{Head}(A, n_A) &\leq \text{Tail}(B, n_B) \text{ (3)} \\
n_B = 0 \text{ or } n_A \geq S_A \text{ or } \text{Head}(B, n_B) &\leq \text{Tail}(A, n_A) \text{ (4)}
\end{aligned}
%%</p>

Let's star first with showing that for any pair of integers \\|n_A\\| and \\|n_B\\| the conditions (1) and (2) implies the lemma conditions (3) and (4):

<p>%%
\begin{aligned}
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) &=    \text{Head}(A \oplus B, n_A + n_B) \\
                                               &\leq \text{Tail}(A \oplus B, n_A + n_B) \\
                                               &\leq \text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B).
\end{aligned}
%%</p>

where the first inequality is because for sorted array its head is always less than or equal to its tail. Now it is trivially true that \\|\text{Head}(X, n_X) \leq \text{Head}(X, n_X)\\| and \\|\text{Tail}(X, n_X) \leq \text{Tail}(X, n_X)\\| as long \\|0 < n_X < S_X\\| where \\|X\\| represent any of the two integers \\|(X = A \text{ or } B)\\|. Therefore, the above expression can only be true if only if the conditions (3) and (4) of the lemma are also true. The conditions (3) and (4) are by definition satisfied in the case that any of the two integers is either \\|0\\|, or equal or greater than \\|S_X\\|.

Now let's show the other way around, and assume that two integers comply with the conditions (3) and (4) and also that both integers comply with \\|0 < n_X < S_X\\| then we notice that:

<p>%%
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) \leq \text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B) \text{ (5)}
%%</p>

But then we can build \\|A \oplus B\\| by <span style="color:red">**simple concatenation**</span> two arrays. These two arrays are the sorted concatenation of the heads and the tails of \\|A\\| and \\|B\\| or

<p>%%
A \oplus B = \text{Head}(A, n_A) \oplus \text{Head}(B, n_B) \textcolor{red}{+} \text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)
%%</p>

where the simple concatenation is possible because of (5), but then this implies by definition that the first(last) \\|n_A+n_B\\| elements of \\|A \oplus B\\| (its head and tail) are given by the sorted and concatenated arrays, meaning therefore that (1) and (2) are true. The conditions (1) and (2) are automatically satisfied in the case that any of the two integers is either \\|0\\| or \\|S_X\\| concluding the proof.

## A new approach

Verify the lemma conditions (3) and (4) is very simple and it can be done in constant time as follow

<p>%%
\begin{aligned}
n_A = 0 \text{ or } n_B \geq S_B \text{ or } A[n_A-1] \leq B[n_B] \text{ (3')}\\
n_B = 0 \text{ or } n_A \geq S_A \text{ or } B[n_B-1] \leq A[n_A] \text{ (4')}
\end{aligned}
%%</p>

due to the fact both A and B are sorted arrays. Therefore the merge-sort map lemma allow us to transform the merge-sort map problem into one where we need to find two integers \\|n_A \leq S_A\\| and \\|n_B \leq S_B\\| where at least one of them is not zero, such as \\|n_A + n_B = n\\| and they also comply with conditions (3') and (4'). The values of the \\|AB\\| n-th element is then simply \\|\text{Value}(n_A, n_B)\\|.

Binary search can be use to find this pair on integers:

* Choose to label the arrays \\|A\\| and \\|B\\| such as it is always true that \\|S_A \leq S_B\\|.
* With thos choice of labels, the binary search is done over the \\|n_A\\| integer.
* Let's define \\|left\\| and \\|right\\| as the left and right values for the range of \\|n_A\\|.
* Initially the values of \\|n_A\\| are between \\|left \leftarrow 0\\| and \\|right \leftarrow \min \lbrace n, S_A \rbrace\\|
  * this initial value for \\|right\\| makes sure that \\|n_A \leq S_A\\| a required condition for solution,
  * also this selection forces \\|n_A \leq n\\| so \\|n_B\\| is always zero or positive.
* Choose the value of \\|n_A\\| by bipartition its range.
* The value of the other integer has to be \\|n_B = n - n_A\\|.
* However, it is possible that \\|n_B > S_B\\|, meaning the value of \\|n_A\\| is too small and therefore the range of the solution should be updated so \\|left \leftarrow n_A + 1\\| and repeat the bipartition.
* Check if conditions (3') and (4') fail:
  * if (3') fails, it means that the value of \\|n_A\\| is too large and therefore the range of the solution should be updated so \\|right \leftarrow n_A - 1\\| and repeate the bipartition.
  * if (4') fails, it means that the value of \\|n_A\\| is too small and therefore the range of the solution should be updated so \\|left \leftarrow n_A + 1\\| and repeat the bipartition.

For the last two points, we rely on the condition that both \\|A\\| and \\|B\\| are sorted arrays, and therefore we know in which direction we need to update our search. Below you can find a python code that implements this search.

{% highlight python %}
def IsNotHeadTailCondition(self, X, Y, nX, nY):
    """Check for the negative of the head-tail condition."""
    return nX > 0 and nY < len(Y) and X[nX-1] > Y[nY]

def GetMergeSortArrayValue(self, A, B, nA, nB):
    """Get the value of merge-sort array."""
    if nA == 0:
        value = B[nB-1]
    elif nB == 0:
        value = A[nA-1]
    else:
        value = max(A[nA-1], B[nB-1])
    return value

def MergeSortMap(self, A, B, n):
    """Help to find the median between arrays."""

    # Array size
    SA = len(A)
    SB = len(B)

    # Sanity check
    if SA == 0 and SB == 0:
        raise Exception('empty both arrays')
    if n < 1 or n > SA + SB:
        raise IndexError('merge-sort map index out of range')

    # Edge case one empty array
    if SA == 0:
        return B[n-1]
    if SB == 0:
        return A[n-1]

    # Check swap arrays to keep A as smaller array
    if SA > SB:
        SA, SB = SB, SA
        A, B = B, A

    # Interval initialization
    left = 0
    right = min(n, SA)

    # Binary search
    while 1:
        # Binapartition of nA range
        nA = (left + right)//2
        # Derive value for nB
        nB = n - nA
        # Check if nB is out of range,
        # meaning nA too small.
        if nB > SB:
            left = nA + 1
        # Check if first head/tail condition tails
        # meaning that nA is too large
        elif self.isNotHeadTailCondition(A, B, nA, nB):
            right = nA - 1
        # Check if first head/tail condition tails
        # meaning that nA is too small
        elif self.isNotHeadTailCondition(B, A, nB, nA):
            left = nA + 1
        # Break if all conditions are met
        else:
            break
    # Get the value of merge-sort array
    return self.getMergeSortArrayValue(A, B, nA, nB)
{% endhighlight %}


## Correctness and time complexity

The correctness of the algorithm comes directly from the merge-sort map lemma that we used to derive the algorithm in the first place.

It is easy to see the complexity of the algorithm is the one given by the binary search in the range of \\|n_A\\|, meaning that the algorithm takes just \\|O(log(S_A))\\| to run because verifying all the solution conditions are done in constant time. However, we choose to label the input vectors so the \\|A\\| is the smaller array. Therefore, for two arbitrary arrays the time complexity is just \\|O(\log(\min\lbrace S_A, S_B\rbrace))\\|!

The solution of the median of two sorted arrays implemented using the merge-sort map also has a time complexity of \\|O(\log(\min\lbrace S_A, S_B\rbrace))\\|. This means we found a more efficient solution to the problem than the one requested in the model.

Do we wonder if this **the most efficient solution** for both problems?

## Final comments

We submitted to LeetCode the merge-sort map problem as a contribution. At the moment of this writing, the problem is pending for review. We wrote most of the code using LeetCode API for automated judging although this is not available for the merge-sort map problem.

The complete implementation of this algorithm can be found in the following links:

* [Merge-Sort Map implemented using LeetCode API for judging.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/merge_sort_map.py)
* [Stress testing of merge-sort map.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/merge_sort_map_stress.py)
* [Median of two sorted arrays using merge-sort map.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/median_two_sorted_arrays.py)
* [Stress testing of the median of two sorted arrays](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/median_two_sorted_arrays_stress.py)

I hope you enjoy the beautiful algorithmic gem that seems hard but once it is understood it becomes trivial!

### References

[^1]: [LeetCode](https://leetcode.com/)
[^2]: [Wikipedia: Median](https://en.wikipedia.org/wiki/Median)
[^3]: [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/)
[^4]: [Wikipedia: Merge sort](https://en.wikipedia.org/wiki/Merge_sort)
[^5]: [Wikipedia: Fixed-point iteration](https://en.wikipedia.org/wiki/Fixed-point_iteration)
[^6]: [C++ version](https://github.com/baites/examples/blob/master/coding/leet/median_two_sorted_arrays_v5.C), [Python version](https://github.com/baites/examples/blob/master/coding/leet/median_two_sorted_arrays_v5.py)
