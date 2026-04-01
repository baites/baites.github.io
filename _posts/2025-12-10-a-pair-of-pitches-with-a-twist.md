---
layout: post
title: A pair of pitches with a twist
date: 2025-12-10 18:00:00 -0400
author: Victor E. Bazterra
categories: music math music-notes-series
javascript:
  katex: true
---

| This blog is part of a series wth all my music notes. [In the Series page you can find all the posts of the series]({{ 'series#music-notes-series' | relative_url}} ). |

* TOC
{:toc}

## Parallel and contrarian motions

In the post [ordered pair of pitches]({% post_url 2024-10-01-ordered-pair-of-pitches %}) I described ordered pair of pitches using group actions. However, in harmony it is more common to refer to pair of pitches based on their intervals regardless their order. In order to understand this point, we start by redefining *real pitch pair* using a different parametrization as follows. 

Let the pitch space $\mathcal{S} \subset \mathbb{R}^2\$ be the set of points in two-dimensional plane, and define the function $p: \mathbb{R}^2\_{>0} \rightarrow \mathbb{R}^2; p(f\_1,f\_2) = b\_1\log\_{a\_1}(f\_1/\hat{f}\_1) \mathbf{e}\_1 + b\_2\log_{a\_2}(f\_2/\hat{f}\_2)\mathbf{e}\_2$ for some parameters $\mathbf{a},\mathbf{b} \in \mathbb{R}^2\_{>0}$ such that the pitch $\mathbf{x} = (0,0)$ correspondes to the standard pitch with associated frequencies $(\hat{f}\_1, \hat{f}\_2)$. Define the group $G = (\mathbb{R}^2, \mathbf{+}, \mathbf{0})$ and the action $\lambda_{(\mu, \delta)}: \mathbb{R}^2 \rightarrow \mathbb{R}^2$ defined as 

$$ \lambda_{(\mu, \delta)}(x_1, x_2) = \frac{1}{2}\left[(\mu-\delta+x_1) \mathbf{e}\\_1 + (\mu+\delta+x_2) \mathbf{e}\\_2\right] $$

This map parametrizes actions as *parallel motions* (controlled by $\mu$)git and *contrary motions* (controlled by $\delta$). In terms of the previous *real pitch pair* definition, $\mu = g_1 + g_2$ and $\delta = g_2 - g_1$. The figure below shows the group actions and thier effect on pitch space. The figure also illustrates how group operations results in the composition of transformation in the pitch space. In particular, the example illustrates the composition rule resulting of group actions, namely that any trajectory that starts and ends at the same group element (here the identity) must also start and end at the same pitch pair (in this case the standard pitch pair). 

{% include image file="mt-action-on-2d-real-pair.svg" scale="80%" %}

## The twist

In harmony, the interval between two pitches is given by the distances between them regardless their order. This means the interval between two pitches is given by absolute value of $\vert\delta\vert$. For example, the action $A = (1.0, 0.5)$ transforms the standard pitch pair into the pair with coordinates $(0.75,0.25) \in \mathcal{S}$. In harmony, usually this is treated as equivalent to it *twisted twin* given by $A^{\prime} = (1.0, -0.5)$ which transforms the standard pitch pair to $(0.25,0.75)$. In music this kind of objects are called dyads[^1].

One way to identify as both action given by $A$ and $A^{\prime}$ is to require their transformations send the pitch same point in $\mathcal{S}$. I say that $A$ and $A^{\prime}$ are equivalent relative to standard pitch $0 \in \mathcal{S}$ if $\lambda_A(0) = \lambda_{A^{\prime}}(0)$ where I refer as $A^{\prime}$ as image of $A$ or viseversa. It is not hard to implement an action $\lambda_{(\mu, \delta)}: \mathbb{R}^2 \rightarrow \mathbb{R}^2$ that the necessary requirements for a *real pitch dyad* as follow

$$
\begin{aligned}
\lambda_{(\mu, \delta)}(x_1, x_2) &= \frac{1}{2}(\mu + x_1 + x_2 - \left\vert\delta + x_2 - x_1\right\vert) \mathbf{e}_1 + \newline
                                  &+ \frac{1}{2}(\mu + x_1 + x_2 + \left\vert\delta + x_2 - x_1\right\vert) \mathbf{e}_2.
\end{aligned}
$$

Below the figure illustrates the result of this transformation over the same action trajectory as above.

{% include image file="mt-action-on-2d-real-dyad.svg" scale="80%" %}

From the plot we must notice that

* Only points in the half-plane above the diagonal line are reachable from standard pitch.
* This is by convention; it would be easy to define a transformation to reaches the lower half-plane as well.
* The action from $A \in G$ to its equivalent $A^{\prime} \in G$ results in a bounce on the diagonal.
* The previous composition rule does not hold $\lambda_{g_1+g_2+g_3}(0) {=}\mathllap{/\,} \lambda_{0}(0)$ !

However, we can make $\lambda_{g_1+g_2+g_3}(0) = \lambda_0(0)$ by an appropiate choice of action as shown in the next graph.

{% include image file="mt-action-on-2d-real-dyad-v2.svg" scale="80%" %}

This shows that the composition rule derived from group actions is not valid in general for dyads, or alternatively, dyads cannot be represented by **group actions**! This means that identifying dyads intervals as equivalent is different from identifying the equivalence of octaves. In the later, that was possible by defining group stebilizer action over homogeneous spaces. We will need a new type of object to decribe the algebra of dyads and its derived structures!

## Disclaimer

{% include statement/disclaimer %}
THE \"KNOWLEDGE\" IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \"KNOWLEDGE\" OR THE USE OR OTHER DEALINGS OF THE \"KNOWLEDGE\".
{% include statement/end %}

Expect conceptual errors and constant updates to the whole blog series. Be skeptical and critical of this series content. **Ultimately, you are responsible for the information you consume.**

## References

[^1]: [Dyad in music.](https://en.wikipedia.org/wiki/Dyad_(music))
