---
layout: post
title: Made up patterns with closures
date: 2017-12-04 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms
---

This is the third post related to my playing around with closures. Here are links to the previous posts.

* [Getting some closures]({% post_url 2017-11-20-getting-some-closures %})
* [Variable lifetime and closures]({% post_url 2017-11-27-variable-lifetime-and-closures %})

In this post, I will show some made up patterns based on closures. I created these patters by myself when research closures. It is likely however, that they are already known and described already by somebody else. Also it is likely they are not really useful at all. Please do not expect much of them, I just made them for fun.

The first pattern is called **freezing mutables by closures**. The pattern uses a closure by copy to create a closure protected copy of a mutable object. In essence the pattern looks like as follow.

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

The call *frozen()* returns a copy of *cache* value that is protected by the closure. The value of *cache* is set by copying *mutable* when calling to *FreezeMutable(mutable)*. Therefore, every call to *frozen()* will return always the same value in cache, even if it is value is made of a mutable object! The program [FreezingMutablesByClosure](https://github.com/baites/examples/blob/master/idioms/python/FreezingMutablesByClosure.py) presents a fully working example in python of the pattern.

The second pattern is a sibling (if not exactly the same) of the previous pattern. I call it **constant property by closure**. In this pattern we set a property as a closure protected copy of a mutable object. The pattern looks basically as shown below.

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

The variable *constant* is a property of the class, with a reference to the *anonymous* or *lambda* function within the closure as its **getter** function. Therefore every time *a.constant* is called, it will return a copy of the closure protected value of *cache*. Moreover, if we try to assigned a new variable to *a.constant*, python interpreter will throw an exception because there is no **setter** function to the *constant* property[^1]. Here there is [a working example](https://github.com/baites/examples/blob/master/idioms/python/ConstantPropertyByClosure.py) of the pattern written in python.

I also worked out javascript examples for [freezing mutables](https://github.com/baites/examples/blob/master/idioms/javascript/FreezingMutableByClosure.js) and for [constant properties](https://github.com/baites/examples/blob/master/idioms/javascript/ConstantPropertyByClosure.js). The main realization you need to have in this case, it is that for javascript *freezing a mutable* is equal to *set constant properties* of an object. This is because, the global namespace in javascript is implemented as an object named **global**. By adding a constant property in *global* using *mutable*, we effectively create a frozen copy of its value.

[^1]: If you like to read more properties in python, I would recommend *Python 3: Object oriented Programming* by *Dusty Phillips*, ch. 5, pg 129. For javascript yo can look at *JavaScript: the definitive guide* by *David Flanagan*, ch. 6, pg. 130.
