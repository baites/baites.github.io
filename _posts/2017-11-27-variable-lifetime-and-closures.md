---
layout: post
title: Variable lifetime and closures
date: 2017-11-27 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms
---

In the [previous blog]({% post_url 2017-11-20-getting-some-closures %}) I discussed what are closures using javascript and python, and also what they are not using examples in C++, javascript, and python. In particular, we saw that closures in javascript and python capture variables like by copy/value or reference depending variable mutability[^1].

We can easily make the variable capture always by copy/value by simply making a deep copy of it. We can also make the copy unreachable (effectively rendering it immutable) by always returning a copy of the captured variable, see for example below.

{% highlight python %}
def CreateClosure(value):
    context = copy.deepcopy(value)
    def method():
        return copy.deepcopy(context)
    return method

closure = CreateClosure('A')

print('', closure())
#> context in closure: A
{% endhighlight %}

If variable *value* is immutable, capturing and returning a copy of it does not change the behavior of *context* because it would not be possible to modify its value in the first place. However, if value is mutable, then the variable referenced by *context* is unreachable outside of the closure. We can only get its value throughout the copy returned by *method()*. See detailed examples for [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/ClosureByCopy.js) and [python](https://github.com/baites/examples/blob/master/idioms/python/ClosureByCopy.py).

It is possible to change the value of *context* by sharing it between closures. One closure is a method to **get** a copy of the value of *context*. Another method, to **set** a new value of *context*. The basic pattern in python is shown below.

{% highlight python %}
def CreateClosure(value):
    """Create two closures with share context."""
    context = copy.deepcopy(value)
    def GetContext():
        return copy.deepcopy(context)
    def SetContext(value):
        nonlocal context
        context = copy.deepcopy(value)
    return GetContext, SetContext
{% endhighlight %}

 Working examples of this pattern can be found in the following links for [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/SharedContextClosures.js) and [python](https://github.com/baites/examples/blob/master/idioms/python/SharedContextClosures.py). Please notice the use of the python keyword **nonlocal**, it is fundamental to access context within *SetContext()* method, see as example a **broken** version with [nonlocal omitted](https://github.com/baites/examples/blob/master/idioms/python/BrokenSharedContextClosures.py).

From these examples, it seems like can we access *context* value outside of the scope in where it was created, meaning **CreateClosure()** function. Sometimes this is referred as the closure *extended the variable lifetime*. **I speculate** that in this case, that *context* variable within the closure is a reference to a memory address with its value. Therefore, as long the closure exists, there is a reference to *context*, and it is accessible through closure methods as it was demonstrated. Because it still remains accessible, the variable is not garbage collected and its lifetime is extended as long the closure is not destroyed.

[^1]: I would like reiterate previous post foot note in here: one that one should be careful of using the notion of **copy/value** and **reference** related closely to C++ but not directly translatable for garbage collected high level languages such python or javascript. This is why I will be using expression such as *behaves like by copy or reference*.
