---
layout: post
title: "Xmas blog: Back propagation in neural networks"
date: 2017-12-25 08:00:00 -0400
author: Victor E. Bazterra
categories: machine-learning deep-learning back-propagation
javascript:
  katex: true
---

<p>%%
\begin{aligned}
z^{[l](i)}_j &= \sum^{n^{[l-1]}}_{k=1} w^{[l]}_{jk} a^{[l-1](i)}_k + b^{[l]}_j \\
a^{[l](i)}_j &= g^{[l]}\left(z^{[l](i)}_j\right)
\end{aligned}
%%</p>

<p>%%
\begin{aligned}
Z^{[l]} &= W^{[l]} A^{[l-1]} + B^{[l]} \\
A^{[l]} &= g^{[l]}\left(Z^{[l]}\right)
\end{aligned}
%%</p>

<p>%%
\mathcal{C} = \frac{1}{m} \sum^m_{i=1} \mathcal{L}\left(A^{[L](i)},Y^{(i)}\right)
%%</p>

For \\|f: \mathbb{R}^n \rightarrow \mathbb{R}\\| and \\|G: \mathbb{R}^m \rightarrow \mathbb{R}^n\\|

<p>%%
\frac{\partial}{\partial x_i} f(G(X)) = \sum^n_{i=1} \frac{\partial f}{\partial g_j}\Big\vert_{G(X)} \frac{\partial g_j}{\partial x_i}\Big\vert_{X}
%%</p>

<p>%%
\begin{aligned}
{\color{blue} da^{[l](i)}_j} = \frac{\partial \mathcal{\color{blue} L}}{\partial a^{[l](i)}_j} & = \sum^{n^{[l+1]}}_{j'=1} \frac{\partial \mathcal{L}}{\partial z^{[l+1](i)}_{j'}} \frac{\partial z^{[l+1](i)}_{j'}}{\partial a^{[l](i)}_j} \\  
&= \sum^{n^{[l+1]}}_{j'=1} dz^{[l+1](i)}_{j'} w^{[l+1]}_{j'j} \\
{\color{blue} dA^{[l]}} &= W^{[l+1]\top} {\color{blue} dZ^{[l+1]}}
\end{aligned}
%%</p>

<p>%%
\begin{aligned}
{\color{blue} dz^{[l](i)}_j} = \frac{\partial \color{blue}\mathcal{L}}{\partial z^{[l](i)}_j} &= \sum^{n^{[l]}}_{j'=1} \frac{\partial \mathcal{L}}{\partial a^{[l](i)}_{j'}} \frac{\partial a^{[l](i)}_{j'}}{\partial z^{[l](i)}_j} \\  
&= \sum^{n^{[l]}}_{j'=1} da^{[l](i)}_{j'} g^{[l]'}\left(z^{[l](i)}_j\right)\delta_{j'j} \\
{\color{blue} dZ^{[l]}} &= {\color{blue} dA^{[l]}} \odot g^{[l]'}\left(Z^{[l]}\right)
\end{aligned}
%%</p>

<p>%%
\begin{aligned}
{\color{red} dw^{[l]}_{jk}} = \frac{\partial \color{red}\mathcal{C}}{\partial w^{[l]}_{jk}} &= \sum^{m}_{i=1}\sum^{n^{[l]}}_{j'=1} \frac{\partial \mathcal{C}}{\partial z^{[l](i)}_{j'}} \frac{\partial z^{[l](i)}_{j'}}{\partial w^{[l]}_{jk}} \\  
&= \frac{1}{m} \sum^{m}_{i=1} {\color{blue} dz^{[l](i)}_{j}} a^{[l-1](i)}_{k} \\
{\color{red} dW^{[l]}} &= \frac{1}{m} {\color{blue} dZ^{[l]}} A^{[l-1]\top}
\end{aligned}
%%</p>

<p>%%
\begin{aligned}
{\color{red} db^{[l]}_{j}} = \frac{\partial \color{red}\mathcal{C}}{\partial b^{[l]}_{j}} &= \sum^{m}_{i=1}\sum^{n^{[l]}}_{j'=1} \frac{\partial \mathcal{C}}{\partial z^{[l](i)}_{j'}} \frac{\partial z^{[l](i)}_{j'}}{\partial b^{[l]}_{j}} \\  
&= \frac{1}{m} \sum^{m}_{i=1} {\color{blue} dz^{[l](i)}_{j}} \\
{\color{red} dB^{[l]}} &= \frac{1}{m} \sum^{m}_{i=1} \left({\color{blue} dZ^{[l]}}\right)_{ji}
\end{aligned}
%%</p>

<p>%%
\begin{aligned}
{\color{blue} dA^{[l]}} &= W^{[l+1]\top} {\color{blue} dZ^{[l+1]}} \\
{\color{blue} dZ^{[l]}} &= {\color{blue} dA^{[l]}} \odot g^{[l]'}\left(Z^{[l]}\right) \\
{\color{red} dW^{[l]}} &= \frac{1}{m} {\color{blue} dZ^{[l]}} A^{[l-1]\top} \\
{\color{red} dB^{[l]}} &= \frac{1}{m} \sum^{m}_{i=1} \left({\color{blue} dZ^{[l]}}\right)_{ji}
\end{aligned}
%%</p>
