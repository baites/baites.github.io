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

It is possible to change the value of *context* by sharing it between closures. In one closure, we define a method to **get** a copy of the value of *context*. In another closure, we create a method to **set** a new value of *context*. The basic pattern in python is shown below.

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

 Working examples of this pattern can be found in the following links for [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/SharedContextClosures.js) and [python](https://github.com/baites/examples/blob/master/idioms/python/SharedContextClosures.py). Please notice the use of the python keyword **nonlocal**, it is fundamental to access *context* within *SetContext()* method, see as example a **broken** version with [nonlocal omitted](https://github.com/baites/examples/blob/master/idioms/python/BrokenSharedContextClosures.py).

From these examples, it seems like we can access *context* value outside of the scope in where it was created, meaning **CreateClosure()** function. Sometimes this is referred as the closure *extended the variable lifetime*. For python, the *context* variable within the closure is a reference to a memory address containing its value. Therefore, as long the closure exists, there is a reference pointing to *context* value, and it is accessible throughout closure methods as it was demonstrated. Because it still remains accessible, the variable is not garbage collected and its lifetime is extended as long as the closure is not destroyed.

I created a small [python code](https://github.com/baites/examples/blob/master/idioms/python/VariableLifetimeInClosure.py) to prove this point. This example uses what I call a *lifetime probe*, that is an object capable of tracking its own lifetime. Using this probe, I create a closure withing the scope of a function instead of the global namespace, as schematically is shown below.

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

Entering and exiting the function scope, the closure is created and destroyed respectively, as long there is not outside reference for awaiting *returned closure*. The [example code](https://github.com/baites/examples/blob/master/idioms/python/VariableLifetimeInClosure.py) just verify that *closure* lifetime is the same as its closure lifetime. For javascript, I think it is safe to assume that follows a similar logic as in python regarding the lifetime of variable within closures.

[^1]: I would like reiterate previous post foot note in here: one that one should be careful of using the notion of **copy/value** and **reference** related closely to C++ but not directly translatable for garbage collected high level languages such python or javascript. This is why I will be using expression such as *behaves like by copy or reference*.
