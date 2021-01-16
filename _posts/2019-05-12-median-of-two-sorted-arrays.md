---
layout: post
title: "Algorithmic magic of the median of two sorted arrays"
date: 2019-05-12 08:00:00 -0400
author: Victor E. Bazterra, Codeforces' Mandinga
categories: algorithms algorithm-analysis
javascript:
  katex: true
---

* TOC
{:toc}

# Here I go again

It is a while since my last post. I stopped blogging for some time because of some personal issues I need to resolve. However, these are technical blogs that are not meant to be mass produced. I write them intending to practice my writing, also to get some bragging rights about my creative and knowledge, and more important because I enjoy it.

# Formalizing algorithms

I decided that I needed to formalize my knowledge about algorithms. Although I have worked with them all my life, I never was *classically train* on them, and therefore I thought it was time for me to do so.

The most crucial step I am taking is to practice following a competitive coding format. I started looking at LeetCode[^1] for coding questions, and this blog is about the first **hard** problem I solved from that site.

The blog was written in collaboration with Codeforces' Mandinga. We were starting sharing some of our solution to the problem, and also some of our approaches to prove our algorithm's correctness and time complexity. My initial attempt to do that with my own solution was very messy at best. Mandinga came up with a framework that made more straightforward to understand how the algorithm works. We worked in defining a notation based on this framework and use it to prove the main lemma that shows that the algorithm is correct. This framework also allows us to write a code that is easy to read and derive its time complexity.

# Median of two arrays

Before going to the specific problem, we need to define what is the median of an array.

> **Definition:** Given an sorted array \\|A[0..S-1]\\| where \\|S\\| is the array size, its median is defined as:
<p>%%
\text{MedianSortedArray}(A) = \begin{cases}
A[m] & \text{if S is odd} \\
\frac{1}{2} \lparen A[m] + A[m - 1] \rparen  & \text{otherwise}
\end{cases}
%%</p>
>where \\|m = \lfloor S/2 \rfloor \\| is the index pointing to the **middle** of the array[^2].

This definition implies the following constant run time algorithm or \\|O(1)\\| to the derive the median that in python looks like as:

{% highlight python %}
def MedianSortedArray(A):
    S = len(A)
    return 0.5*(A[(S-1)//2] + A[S//2])
{% endhighlight %}

The median of an arbitrary array can be computed simply by sorting the array first and then using the **MedianSortedArray** method

{% highlight python %}
def MedianOneArray(A):
    A.sort()
    return MedianSortedArray(A)
{% endhighlight %}

The runtime of this algorithm is \\|O(S \log S)\\| where all of it comes from the need to sort the array first and \\|O(1)\\| in memory if we allow in-place sorting. It is easy to extend this definition for the case of having two arrays in where their median is just the median of their concatenation.

{% highlight python %}
def MedianTwoArrays(A, B):
    return MedianOneArray(A + B)
{% endhighlight %}

With these definitions in place, the LeetCode's coding question that inspired this blog is the follow.

> **Problem:** There are two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\| of size \\|S_A\\| and \\|S_B\\| respectively. Find the median of the two sorted arrays with a time complexity \\|O(\log(S_A+S_B))\\| and in constant space complexity. You may assume \\|A\\| and \\|B\\| cannot be both empty.[^3]

It is easy to see this problem can have a linear solution \\|O(S_1 + S_2)\\| in time and space complexities by exploiting the fact both input arrays are sorted. The trick is to use the *merge step* of the merge-sort algorithm[^4] to concatenate the two sorted arrays in a third sorted array \\|F\\| and then call **MedianSortedArray** method.

{% highlight python %}
def MergeArrays(A, B):
    SA = len(A)
    SB = len(B)
    F = [0]*(SA+SB)
    iA = 0; iB = 0
    while iA < SA or iB < SB:
        AHeadIsSmaller = (iA != SA) && (iB == SB || [iA] < B[iB])
        if AHeadIsSmaller:
            F[iA+iB] = A[iA]
            iA += 1
        else:
            F[iA+iB] = B[iB]
            iB += 1
    return F

def MergeMedianTwoSortedArrays(A, B):
    F = MergeArrays(A, B)
    return MedianSortedArray(F)
{% endhighlight %}

The question is now how can we improve upon this solution.

# Exploring properties of the sorted concatenation

We adopt the following notation to simplify the subsequent discussion of the problem. We annotate concatenation of two arbitrary arrays \\|A\\| and \\|B\\| as \\|A + B\\| and their sorted concatenation as \\|A \oplus B\\|

<p>%%
A \oplus B = \text{Sort}(A+B) \text{ (d.1)}.
%%</p>

An essential property of the sorted concatenation is that its result is independent of the order of the input arrays, meaning the concatenated sort obeys the commutative property[^5]

<p>%%
A \oplus B = B \oplus A \text{ (p.2).}
%%</p>

It is also easy to see that the sorted concatenation obeys also the associative property[^5] or

<p>%%
(A \oplus B) \oplus C = A \oplus (B \oplus C) \text{ (p.3).}
%%</p>

We say that two nonempty arrays \\|A\\| and \\|B\\| are \\|A \leq B\\| if it is true that for all elements of \\|A\\| are less or equal to any element of \\|B\\|. We let the reader to prove that the following property relates the simple and sorted concatenations by the condition

<p>%%
A \leq B \Leftrightarrow A \oplus B = A + B.
%%</p>

In words, all the elements of \\|A\\| are less or equal to any element of \\|B\\| if and only if the sorted concatenation between both arrays is only the simple concatenation between them. We promote this property as the actual definition for the condition \\|A \leq B\\| by writing

<p>%%
A \leq B \doteq A \oplus B = A + B \text{ (d.4)}
%%</p>

The main advantage of using the definition (d.4) is that it also works for the cases in where one or both arrays are empty. This is because for a non-empty array \\|A\\| then (d.4) implies

<p>%%
\begin{aligned}
A \oplus [] = A + [] \Leftrightarrow & A \leq [] \\
[] \oplus A = [] + A \Leftrightarrow & [] \leq A \\
[] \oplus [] = [] + [] \Leftrightarrow & [] \leq []
\end{aligned}
%%</p>

In the case of having two sorted arrays \\|A\\| and \\|B\\|, condition (d.4) can be verified in constant time as follow

<p>%%
A \leq B \equiv S_A = 0 \text{ or } S_B = 0 \text{ or } A[S_A-1] \leq B[0] \text{ (p.5)}
%%</p>

We define the \\|\text{Head}(A,n)\\| where \\|A[0..S_A-1]\\| is an array and \\|n\\| an integer such as \\|n \in [0, S_A]\\|, as the array form by the first \\|n\\| elements of \\|A\\|. In particular, we say that \\|\text{Head}(A,0)\\| is an empty array, and also that \\|A =  \text{Head}(A,S_A)\\|.

In a complementary way, we write \\|\text{Tail}(A,n)\\| as the resulting array after removing the first \\|n\\| elements of \\|A\\| such as \\|A = \text{Head}(A,n) + \text{Tail}(A,n)\\| for any value of \\|n \in [0, S_A]\\|. From this definition it should be clear that \\|A = \text{Tail}(A,0)\\|, and that \\|\text{Tail}(A,S_A)\\| is an empty array.

We would like to remark that if an array \\|A\\| is already sorted, then for any the value of \\|n \in [0, S_A]\\|

<p>%%
A = \text{Head}(A,n) + \text{Tail}(A,n) = \text{Head}(A,n) \oplus \text{Tail}(A,n) \text{ (p.6)}
%%</p>

and therefore by definition (d.4), its head is always less or equal than its tail or:

<p>%%
\text{Head}(A,n) \leq \text{Tail}(A,n) \text{ for all } n \in [0, S_A] \text{ (p.7).}
%%</p>

For an arbitrary group of arrays \\|A\\|, \\|X\\|, \\|Y\\|, and \\|F\\| it is easy to see that

<p>%%
A + X = F \text{ and } A + Y = F \Leftrightarrow X = Y \text{ (p.8).}
%%</p>

An equivalent property for the sorted concatenation can be obtained in the case that all the arrays \\|A\\|, \\|X\\|, \\|Y\\|, and \\|F\\| are already sorted where in this case

<p>%%
A \oplus X = F \text{ and } A \oplus Y = F \Leftrightarrow X = Y \text{ (p.9).}
%%</p>

It is easy to see that if \\|X = Y\\| then left side of (p.9) has to be true. However, to show the opposite direction of (p.9) we need to define first \\|N(X,v)\\| the number of elements in the array \\|X\\| with value \\|v\\|. If a given value \\|u\\| is not present in the array \\|X\\| then we say \\|N(X,u) = 0\\|. Two sorted arrays \\|X\\| and \\|Y\\| are equal if and only if for all the values of \\|v\\| present in \\|X\\| or \\|Y\\| it is true that \\|N(X,v) = N(Y,v)\\|[^5]. Now, we can see that the left size of the property (p.9) implies that \\|N(A,v) + N(X,v) = N(F,v)\\|, and also, that \\|N(A,v) + N(Y,v) = N(F,v)\\| for all the values \\|v\\| present in \\|F\\|. This means that \\|N(X,v) = N(Y,v)\\| for all the values of \\|F\\| that includes all the possible values of \\|X\\| and \\|Y\\|, and therefore because both arrays elements are sorted then \\|X = Y\\|.

# The merge-sort map problem

Finding the median of two sorted arrays can be thought of as a particular case of a more generic problem we call the merge-sort map problem.


> **Merge-Sort Map Problem:** Given two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\|, let's define \\|F\\| as the sorted concatenation of \\|A\\| and \\|B\\| \\|\left(F = A \oplus B\right)\\|, then find the value of the \\|n\\|-th element of \\|F\\| for any \\|n \in [1, S_A+S_B]\\| with a sub-linear runtime and \\|O(1)\\| space complexities. It is safe to assume that at least one of the arrays is not empty.

We call this problem the Merge-Sort Map problem because we would like to find a function that points to the value of the merge-sort array \\|F\\| without actually building it. This is because the problem can be easily solved by merging the two sorted arrays using **MergeArrays** method defined in previous sections. However, this renders the problem to a \\|O(S_A + S_B)\\| time and space complexity required to merge the arrays. However, if it is possible to know the value of sort-merge array in any position more efficiently, then it becomes easy to find the median of these two arrays by running **MedianSortedArray** method.

A solution to the merge-sort map problem can be formulated as follow. Assume you have two integers \\|n_A \in [0, S_A]\\| and \\|n_B \in [0, S_B]\\| and it is true that

<p>%%
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) = \text{Head}(A \oplus B, n_A + n_B) \text{ (c.10)}
%%</p>

then the value for the \\|n\\|-th element of the merge-sort array \\|F\\| where \\|n = n_A + n_B\\| is given by following function

<p>%%
\begin{aligned}
\text{Value}(n_A,n_B) &\doteq  \begin{cases}
A[n_A-1] & \text{if } n_B = 0 \\
B[n_B-1] & \text{if } n_A = 0 \text{ (e.11)}\\
\max\{A[n_A-1], B[n_B-1]\} & \text{otherwise}
\end{cases}
\end{aligned}
%%</p>

Next figure shows an example of the above condition for two arbitrary arrays. This reformulation is just equivalent to build a sort-merge array explicitly. However, we can show this approach becomes useful to find the most efficient way of solving the problem in the coming sections.

{% include image file="median-two-sorted-arrays-fig-1a.svg" scale="80%" %}
<center><p>Head and tail relationships for a sort-merge array.</p></center>

The merge-sort array also has a complementary tail relationship in where for those \\|n_A\\| and \\|n_B\\| complying with the previous condition (c.10) we can write

<p>%%
\begin{aligned}
A \oplus B &= \left[\text{Head}(A, n_A) \oplus \text{Tail}(A, n_A)\right] \oplus \left[\text{Head}(B, n_B) \oplus \text{Tail}(B, n_B)\right] \text{ (using p.6 on A and B)} \\
           &= \left[\text{Head}(A, n_A) \oplus \text{Head}(B, n_B)\right] \oplus \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right] \text{ (because of p.2 and p.3)} \\
           &= \text{Head}(A \oplus B, n_A + n_B) \oplus \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right] \text{ (using c.10 assumed to be true)}
\end{aligned}
%%</p>

Due to (p.6) we know also that \\|A \oplus B =  \text{Head}(A \oplus B, n) \oplus \text{Tail}(A \oplus B, n)\\| for any \\|n \in [0, S_A + S_B]\\|. But then because of (p.9) then it has to true that

<p>%%
\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B) = \text{Tail}(A \oplus B, n_A + n_B) \text{ (c.12)}
%%</p>

# The merge-sort map lemma

As formulated, the head-tail relationships (c.10) and (c.12) presented in the previous section is not enough to help us building a more efficient way of solving the problem. However, the following lemma provides us with a new set of head-tail relationships that can be verified efficiently.

> **Lemma (merge-sort map)**: Given two sorted arrays \\|A[0..S_A-1]\\| and \\|B[0..S_B-1]\\| and two positive integer \\|n_A\\| and \\|n_B\\|, then they comply with the head-tail conditions (c.10) (and therefore also (c.12)) if and only if it is true that

<p>%%
\begin{aligned}
\text{Head}(A, n_A) &\leq \text{Tail}(B, n_B) \text{ (c.13) and} \\
\text{Head}(B, n_B) &\leq \text{Tail}(A, n_A) \text{ (c.14)}
\end{aligned}
%%</p>

Let's star first with showing that for any pair of integers \\|n_A\\| and \\|n_B\\| the conditions (c.10) and (c.12) implies the lemma conditions (c.13) and (c.14):

<p>%%
\begin{aligned}
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) &=    \text{Head}(A \oplus B, n_A + n_B) \text{ (using c.10 assumed to be true)}\\
                                               &\leq \text{Tail}(A \oplus B, n_A + n_B) \text{ (using p.7)}\\
                                               &\leq \text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B) \text{ (using c.12 implied by c.10)}.
\end{aligned}
%%</p>

where the first inequality is because for sorted array its head is always less than or equal to its tail. Now property (p.7) is also true for sorted arrays \\|X = A \text{ or } B\\| and therefore \\|\text{Head}(X, n_X) \leq \text{Tail}(X, n_X)\\| for \\|n_X \in [0, S_X]\\|. As result, the above expression can only be true if only if the conditions (c.13) and (c.14) of the lemma are also true.

Now let's show the other way around and assume that two integers \\|n_A\\| and \\|n_B\\| comply with the conditions (c.13) and (c.14). In the case that \\|n_A + n_B = 0\\| then by definition \\|\text{Head}(A \oplus B, n_A + n_B)\\|,\\|\text{Head}(A, n_A)\\|, and \\|\text{Head}(B, n_B)\\| are all empty arrays and therefore condition (c.10) is trivially true.

Alternative, if \\|n_A + n_B = n\\| where \\|n > 0\\| we can select the first element of the \\|\text{Head}(A \oplus B, n_A + n_B)\\| that is the smallest element of \\|A \oplus B\\|. This element must be present in some of the following four arrays \\|\text{Head}(A, n_A)\\|, \\|\text{Head}(B, n_B)\\|, \\|\text{Tail}(A, n_A)\\|, or \\|\text{Tail}(B, n_B)\\|. However, it cannot be present in the tail of \\|A\\| or \\|B\\| because this would contradict the condition (c.13) or (c.14) that are assumed to be true. Therefore, the first element of \\|\text{Head}(A \oplus B, n_A + n_B)\\| has to be in either \\|\text{Head}(A, n_A)\\| or \\|\text{Head}(B, n_B)\\|. We can then remove the first element from \\|\text{Head}(A \oplus B, n_A + n_B)\\|, and from \\|\text{Head}(A, n_A)\\| or \\|\text{Head}(B, n_B)\\|, allowing us to do the same argument in the case \\|n_A + n_B = n - 1\\|. It is possible to repeat this argument until \\|\text{Head}(A \oplus B, n_A + n_B)\\| is an empty array. But then, all the elements of \\|\text{Head}(A \oplus B, n_A + n_B)\\| come from either \\|\text{Head}(A, n_A)\\| or \\|\text{Head}(B, n_B)\\| implying condition (c.10) is true.

Because we considered this part of the proof critical for proving algorithm correctness, we provide an alternative demonstration in an appendix section by the end of this post.

# A new approach

Verify the lemma conditions (c.13) and (c.14) is very simple, and it can be done in constant time because of property (p.5)

<p>%%
\begin{aligned}
n_A = 0 \text{ or } n_B = S_B \text{ or }& A[n_A-1] \leq B[n_B] \text{ (c.13') and}\\
n_B = 0 \text{ or } n_A = S_A \text{ or }& B[n_B-1] \leq A[n_A] \text{ (c.14')}
\end{aligned}
%%</p>

due to the fact, both A and B are sorted arrays. Therefore the merge-sort map lemma allow us to transform the merge-sort map problem into one where we need to find two positive integers \\|n_A \leq S_A\\| and \\|n_B \leq S_B\\| such as \\|n_A + n_B = n\\| and also they comply with conditions (c.13') and (c.14'). The values of the n-th element in the merge-sort array \\|F\\| is then given by (e.11).

We can use a binary search can be use to find this pair on integers:

* Choose to label the arrays \\|A\\| and \\|B\\| such as it is always true that \\|S_A \leq S_B\\|.
* Using these labels, the binary search is done over the \\|n_A\\| integer.
* Let's define \\|left\\| and \\|right\\| as the left and right values of the range of \\|n_A\\|.
* Initially the values of \\|n_A\\| are between \\|left \leftarrow 0\\| and \\|right \leftarrow \min \lbrace n, S_A \rbrace\\|
  * this initial value for \\|right\\| makes sure that \\|n_A \leq S_A\\|, as required condition for solution,
  * also this selection forces \\|n_A \leq n\\| so \\|n_B\\| is always positive.
* Choose a value of \\|n_A\\| by bipartitioning its range.
* The value of the other integer has to be \\|n_B = n - n_A\\|.
* However, it is possible that \\|n_B > S_B\\|, meaning the value of \\|n_A\\| is too small and therefore the range of the solution should be updated so \\|left \leftarrow n_A + 1\\| and repeat the bipartition.
* Check if conditions (c.13') and (c.14') fail:
  * if (c.13') fails, it means that the value of \\|n_A\\| is too large and therefore the range of the solution should be updated so \\|right \leftarrow n_A - 1\\| and repeate the bipartition.
  * if (c.14') fails, it means that the value of \\|n_A\\| is too small and therefore the range of the solution should be updated so \\|left \leftarrow n_A + 1\\| and repeat the bipartition.

For the last two points, we rely on the condition that both \\|A\\| and \\|B\\| are sorted arrays, and therefore we know in which direction we need to update our search. Below you can find a python code that implements this search.

{% highlight python %}
def IsNotHeadTailCondition(self, X, Y, nX, nY):
    """Check for the negative of the head-tail condition."""
    return nX > 0 and nY < len(Y) and X[nX-1] > Y[nY]

def GetMergeSortArrayValue(self, A, B, nA, nB):
    if nA == 0:
        value = B[nB-1]
    elif nB == 0:
        value = A[nA-1]
    else:
        value = max(A[nA-1], B[nB-1])
    return value

def MergeSortMap(self, A, B, n):
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
        # Check if first head/tail condition fails
        # meaning that nA is too large
        elif self.IsNotHeadTailCondition(A, B, nA, nB):
            right = nA - 1
        # Check if second head/tail condition fails
        # meaning that nA is too small
        elif self.IsNotHeadTailCondition(B, A, nB, nA):
            left = nA + 1
        # Break if all conditions are met
        else:
            break
    # Get the value of merge-sort array
    return self.getMergeSortArrayValue(A, B, nA, nB)
{% endhighlight %}


# Correctness and time complexity

The correctness of the algorithm comes directly from the merge-sort map lemma that we used to derive the algorithm in the first place.

It is easy to see the complexity of the algorithm is dominated by the binary search in the range of \\|n_A\\|. This means that the algorithm takes just \\|O(log(S_A))\\| to run because verifying all the solution conditions are done in constant time. However, we choose to label the input vectors so the \\|A\\| is the smaller array. Therefore, for two arbitrary sorted arrays the time complexity is just \\|O(\log(\min\lbrace S_A, S_B\rbrace))\\|!

The solution of the median of two sorted arrays implemented using the merge-sort map also has a time complexity of \\|O(\log(\min\lbrace S_A, S_B\rbrace))\\|. This means we found a more efficient solution to the problem than the one required by the LeetCode's problem statement.

Do we wonder if this **the most efficient solution** for both problems?

An early python [version of this algorithm plus a few optimizations](https://github.com/baites/examples/blob/master/coding/leetcode/median_two_sorted_arrays_v5.py) run in the LeetCode's judging in 52 ms or faster than 99.36% of the other python submissions. The [same code written in C++](https://github.com/baites/examples/blob/master/coding/leetcode/median_two_sorted_arrays_v5.C) took 40ms or faster than 97.04% of other C++ submission.

# Final comments

We submitted to LeetCode the merge-sort map problem as a contribution. At the moment of this writing, the problem is pending for review. We wrote most of the code using LeetCode API for automated judging although this is not available for the merge-sort map problem.

The complete implementation of all the algorithms can be found in the following links:

* [Merge-Sort Map implemented using LeetCode API for judging.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/merge_sort_map.py)
* [Stress testing of merge-sort map.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/merge_sort_map_stress.py)
* [Median of two sorted arrays using merge-sort map.](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/median_two_sorted_arrays.py)
* [Stress testing of the median of two sorted arrays](https://github.com/baites/examples/blob/master/coding/contribs/merge-sort-map/median_two_sorted_arrays_stress.py)

I hope you enjoy this beautiful algorithmic gem, that it seems hard, but once it is understood, it is rather trivial!

## Update

After finish and publish this blog, we looked at the solution as documented in LeetCode because we avoid looking at it until we were done posting our solution.

* [LeetCode documented solution](https://leetcode.com/problems/median-of-two-sorted-arrays/solution/).

We are happy (and also a bit disappointing) to find out that LeetCode solution is basically the one we developed for this blog. We came with the solution by ourselves as you can see by the different style we used to derive the algorithm. We thought (naively) that we might have a better solution because the problem statement says the answer should be in \\|O(\log(S_A+S_B))\\| runtime complexity and not in \\|O(\log(\min\lbrace S_A, S_B\rbrace))\\| as it is in our case. However, the statement about algorithm complexity is corrected when explaining their solution.

We do not think that much is lost though. This was never about an algorithm breakthrough. This is was always about explaining and bringing to your attention this algorithmic beauty.

## Appendix

### Another approach to prove the lemma other way around

This is another way to prove correctness. However, this approach requires the use of several properties of the sorted arrays so we decided to add it as appendix to the blog.

Let's assume that two integers comply with the conditions (c.13) and (c.14) we notice by doing the sorted concatenation of the left side and right side of both conditions we get

<p>%%
\text{Head}(A, n_A) \oplus \text{Head}(B, n_B) \leq \text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B) \text{ (c.15)}
%%</p>

But then we can build \\|A \oplus B\\| by <span style="color:red">**simple concatenation**</span> two arrays:

<p>%%
\begin{aligned}
A \oplus B &= \text{Head}(A \oplus B, n_A+n_B) \oplus \text{Tail}(A \oplus B, n_A+n_B) \left(\text{using p.6 on } A \oplus B\right) \\
           &= \left[\text{Head}(A, n_A) \oplus \text{Tail}(A, n_A)\right] \oplus \left[\text{Head}(B, n_B) \oplus \text{Tail}(B, n_B)\right] \text{ (using p.6 on A and B)} \\
           &= \left[\text{Head}(A, n_A) \oplus \text{Head}(B, n_B)\right] \oplus \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right] \text{ (because of p.2 and p.3)} \\
           &= \left[\text{Head}(A, n_A) \oplus \text{Head}(B, n_B)\right] \textcolor{red}{+} \left[\text{Tail}(A, n_A) \oplus \text{Tail}(B, n_B)\right] \text{ (using c.15 and d.4).}
\end{aligned}
%%</p>

But then this implies by definition that the first(last) \\|n_A+n_B\\| elements of \\|A \oplus B\\| (its head and tail) are sorted concatenated the heads(tails) of \\|A\\| and \\|B\\|, meaning therefore that (c.10) and (c.12) are true.

### References

[^1]: [LeetCode](https://leetcode.com/)
[^2]: [Wikipedia: Median](https://en.wikipedia.org/wiki/Median)
[^3]: [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/)
[^4]: [Wikipedia: Merge sort](https://en.wikipedia.org/wiki/Merge_sort)
[^5]: This property needs to be proven so we invite the reader to try it out.
