---
layout: post
title: Made up patterns with closures
date: 2017-12-04 10:30:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms closure-series
---

| This blog is part of a series dedicated to function closures. [In the Series page you can find the other posts of the series]({{ 'series#closure-series' | relative_url }} ). |

In this post, I will show some made up patterns based on closures. I created these patterns by myself when research closures. It is likely, however, that they are already known and described previously by somebody else. Also, it is expected they are not useful at all. Please do not expect much of them; I just made them for fun.

I will call the first pattern **freezing mutables by closures**. The pattern uses a closure copy to create *a closure protected copy of a mutable object*. In essence, the pattern looks like as follow.

{% highlight python %}
def FreezeMutable(value):
    """Create a closure protected copy of value."""
    cache = copy.deepcopy(value)
    return lambda: copy.deepcopy(cache)

mutable = {
    'A': [1, 2],
    'B': 'cannot be change'
}

frozen = FreezeMutable(mutable)
print(frozen())
#> {'A': [1, 2], 'B': 'cannot be change'}
{% endhighlight %}

The call *frozen()* returns a copy of *cache* value that is protected by the closure. The value of *cache* is set by copying *mutable* when calling to *FreezeMutable(mutable)*. Therefore, every call to *frozen()* will always return the same value in cache, even if it is value is made of a mutable object! The program [FreezingMutablesByClosure](https://github.com/baites/examples/blob/master/idioms/python/FreezingMutablesByClosure.py) presents a fully working example in python of the pattern.

The second pattern is a sibling (if not the same) of the previous pattern. I call it **constant property by closure**. In this pattern, we set a property as a closure protected copy of a mutable object. The pattern looks as shown below.

{% highlight python %}
def ConstantProperty(value):
    """Create a closure protected constant copy of value."""
    cache = copy.deepcopy(value)
    return property(
        lambda self: copy.deepcopy(cache)
    )

class A(object):
    def __init__(self, value):
        """Class constructor."""
        A.constant = ConstantProperty(value)
{% endhighlight %}

The variable *constant* is a property of the class, with a reference to the *anonymous* or *lambda* function within the closure as its **getter** function. Therefore every time *a.constant* is called, it will return a copy of the closure protected value of *cache*. Moreover, if we try to assign a new variable to *a.constant*, python interpreter will throw an exception because there is no **setter** function to the *constant* property[^1]. Here there is [a working example](https://github.com/baites/examples/blob/master/idioms/python/ConstantPropertyByClosure.py) of the pattern written in python.

I also worked out javascript examples for [freezing mutables](https://github.com/baites/examples/blob/master/idioms/javascript/FreezingMutableByClosure.js) and [constant properties](https://github.com/baites/examples/blob/master/idioms/javascript/ConstantPropertyByClosure.js). It is important to realize in this case, it is that for javascript *freezing a mutable* is equal to *set constant properties* of an object. This is because the global namespace in javascript is implemented as an object named **global**. By adding a constant property in *global* using the value pointed by *mutable*, we effectively create a frozen copy of this value.

# References

[^1]: If you like to read more properties in python, I would recommend *Python 3: Object-oriented Programming* by *Dusty Phillips*, ch. 5, pg 129. For javascript you can look at *JavaScript: the definitive guide* by *David Flanagan*, ch. 6, pg. 130.
