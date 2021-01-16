---
layout: post
title: Variable lifetime and closures
date: 2017-11-27 04:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms closure-series
---

| This blog is part of a series dedicated to function closures. [In the Series page you can find the other posts of the series]({{ 'series#closure-series' | relative_url }} ). |

In the [previous blog]({% post_url 2017-11-20-getting-some-closures %}) I discussed what are closures using javascript and python, and I also explained what they are not using examples in C++, javascript, and python. In particular, I showed that closures in javascript and python capture variables as like by copy/value or reference depending on variable mutability[^1].

You can quickly make the variable capture always by copy/value by merely making a deep copy of it. You can also make the copy unreachable (basically rendering it immutable) by always returning a copy of the captured variable as shown in the example below.

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

If variable *value* is immutable, capturing and returning a copy of it does not change the behavior of *context* because it would not be possible to modify its value in the first place. However, if the value is mutable, then the variable referenced by *context* is unreachable outside of the closure. We can only get its value throughout the copy returned by *method()*. See detailed examples for [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/ClosureByCopy.js) and [python](https://github.com/baites/examples/blob/master/idioms/python/ClosureByCopy.py).

It is possible to change the value of *context* by sharing it between closures. In one closure, we define a method to **get** a copy of the value of *context*. In another closure, we create a method to **set** a new value for *context*. I show the basic pattern in python below.

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

I wrote also working examples of this pattern in [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/SharedContextClosures.js) in [python](https://github.com/baites/examples/blob/master/idioms/python/SharedContextClosures.py). Please notice that the use of the python keyword **nonlocal** is fundamental to access *context* within *SetContext()* method, see an example a **broken** version with [nonlocal omitted](https://github.com/baites/examples/blob/master/idioms/python/BrokenSharedContextClosures.py).

From these examples, it seems like we can access *context* value outside of the scope in where it was created, meaning **CreateClosure()** function. Sometimes this is referred as the closure *extended the variable lifetime*. For python, the *context* variable within the closure is a reference to a memory address containing its value. Therefore, we just demonstrated that as long the closure exists, there is a reference pointing to the value of *context*, and it is accessible throughout closure methods. Because *context* value remains available, the variable value is not garbage collected and its lifetime is extended as long as the closure is not destroyed.

I created a small [python code](https://github.com/baites/examples/blob/master/idioms/python/VariableLifetimeInClosure.py) to prove this point. This example uses what I call a *lifetime probe*, that is an object capable of tracking its lifetime. Using this probe, I created a closure within the scope of a function instead of the global namespace, as schematically is shown below.

{% highlight python %}
def main():
    """First scope where closure lives"""
    def CreateClosure(value):
        """Create closure forcing capture by copy or value."""
        context = copy.deepcopy(value)
        def Method():
            return copy.deepcopy(context)
        return Method
    probe = LifetimeProbe()
    closure = CreateClosure(probe)
    return closure
{% endhighlight %}

Entering and exiting the function scope, the closure is created and destroyed respectively, as long there is not outside reference awaiting *returned closure*. The [example code](https://github.com/baites/examples/blob/master/idioms/python/VariableLifetimeInClosure.py) just verify that the variable lifetime with name *closure* is the same as closure lifetime. For javascript, I think it is safe to assume that it follows a similar logic as python regarding the lifetime of variables within closures.

# References

[^1]: One should be careful of using the notion of **copy/value** and **reference** related closely to C++ but not directly translatable for garbage collected high-level languages such python or javascript. This is why I will be using the expression *behaves like by copy or reference*.
