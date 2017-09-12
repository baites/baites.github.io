---
layout: post
title:  "Welcome to Jekyll!"
date:   2017-09-05 21:56:25 -0400
categories: jekyll update
javascript:
  mathjax: "cdnjs"
  katex: true
  pseudocode: true  
---

You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}


Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

Here is an example MathJax inline rendering \\( 1/x^{2} \\), and here is a block rendering: \\[ \frac{1}{n^{2}} \\]

$$\begin{eqnarray*}
    F(z) & = & \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1}\sum_{n\geq M} a_m f_{n-m} z^n\\
    & = & \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m \sum_{n\geq M-m} f_n z^n \\
    & = & \sum^{M-1}_{n=0} b_n z^n + \sum^{M-1}_{m=1} a_m z^m \left(F(z)  - \sum^{M-m-1}_{n = 0} b_n z^n \right) + a_M z^M F(z) \\
    & = & \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m F(z) - \sum^{M-1}_{m=1} \sum^{M-m-1}_{n = 0} a_m b_n z^{n+m} \\
    Q(z)F(z) & = & \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{m=1} \sum^{M-1}_{n = m} a_m b_{n-m} z^n \\
    Q(z)F(z) & = & \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{n=1} \sum^{n}_{m = 1} a_m b_{n-m} z^n \\
    Q(z)F(z) & = & P(z)
\end{eqnarray*}$$

Here is an example inline \\| x^2 \\| Katex:

<p>%%
\begin{aligned}
    F(z) &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1}\sum_{n\geq M} a_m f_{n-m} z^n\\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m \sum_{n\geq M-m} f_n z^n \\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M-1}_{m=1} a_m z^m \left(F(z)  - \sum^{M-m-1}_{n = 0} b_n z^n \right) + a_M z^M F(z) \\
    &= \sum^{M-1}_{n=0} b_n z^n + \sum^{M}_{m=1} a_m z^m F(z) - \sum^{M-1}_{m=1} \sum^{M-m-1}_{n = 0} a_m b_n z^{n+m} \\
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{m=1} \sum^{M-1}_{n = m} a_m b_{n-m} z^n \\
    Q(z)F(z) &= \sum^{M-1}_{n=0} b_n z^n - \sum^{M-1}_{n=1} \sum^{n}_{m = 1} a_m b_{n-m} z^n \\
    Q(z)F(z) &= P(z)
\end{aligned}
%%</p>

Here an example of pseudocode based on katex:

{% include pseudocode id="quicksort" lineNumber=true code="
\begin{algorithm}
\caption{Quicksort}
\begin{algorithmic}
\PROCEDURE{Quicksort}{$A, p, r$}
    \IF{$p < r$}
        \STATE $q = $ \CALL{Partition}{$A, p, r$}
        \STATE \CALL{Quicksort}{$A, p, q - 1$}
        \STATE \CALL{Quicksort}{$A, q + 1, r$}
    \ENDIF
\ENDPROCEDURE
\PROCEDURE{Partition}{$A, p, r$}
    \STATE $x = A[r]$
    \STATE $i = p - 1$
    \FOR{$j = p$ \TO $r - 1$}
        \IF{$A[j] < x$}
            \STATE $i = i + 1$
            \STATE exchange
            $A[i]$ with $A[j]$
        \ENDIF
        \STATE exchange $A[i]$ with $A[r]$
    \ENDFOR
\ENDPROCEDURE
\end{algorithmic}
\end{algorithm}
" %}

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
