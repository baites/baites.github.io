---
layout: post
title: "Constant and frozen variables in Python"
date: 2019-08-16 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms
---

## Wait what, constants in Python?

This post in the result a question I found in StackOverflow and some research I was doing about Python idioms. The problem is basically *how do I create a constant in Python?*.[^1]

In principle, this is not possible because as [Alex Martelli](https://en.wikipedia.org/wiki/Alex_Martelli) put it in Python *any variable can be re-bound at will*.[^2] This impossibility is a feature of the language and not a limitation. The most accepted pythonic way of having a constant is by name convention. Once developers agree upon a way to designate a constant **they just do not change it**.

However, Python is such a dynamic language that allows the creation of a construct that looks and feels as a constant. This blog is to explore what can be expressed by the language. Likely, you do not need these idioms, please be careful and do not attempt this at home!

In this post, I will call a constant variable to a constant reference to values (immutable or otherwise). Moreover, I say that a variable has a frozen value when it references a mutable object that a client-code to update its value(s).

Now, without further ado, here are the idioms.

## A space of constants (SpaceConstants)

This idiom creates what looks like a namespace of constant variables (a.k.a. SpaceConstants). It is a modification of a code snippet by Alex[^2] to avoid the use of module objects. In particular, this modification uses what I call a class factory because within **SpaceConstants** function, a class called **SpaceConstants** is defined, and an instance of it is returned.

I explored the use of class factory to implement a policy-based design look-alike in Python in stackoverflow[^3] and also in a blog[^4].

{% highlight python %}
def SpaceConstants():
    def setattr(self, name, value):
        if hasattr(self, name):
            raise AttributeError(
                "Cannot reassign members"
            )
        self.__dict__[name] = value
    cls = type('SpaceConstants', (), {
        '__setattr__': setattr
    })
    return cls()

sc = SpaceConstants()

print(sc.x) # raise "AttributeError: 'SpaceConstants' object has no attribute 'x'"
sc.x = 2 # bind attribute x
print(sc.x) # print "2"
sc.x = 3 # raise "AttributeError: Cannot reassign members"
sc.y = {'name': 'y', 'value': 2} # bind attribute y
print(sc.y) # print "{'name': 'y', 'value': 2}"
sc.y['name'] = 'yprime' # mutable object can be changed
print(sc.y) # print "{'name': 'yprime', 'value': 2}"
sc.y = {} # raise "AttributeError: Cannot reassign members"
{% endhighlight %}

## A space of frozen values (SpaceFrozenValues)

This next idiom is a modification of the **SpaceConstants** in where referenced mutable objects are frozen. This implementation exploits what I call *shared closure* between **setattr** and **getattr** functions[^5]. The value of the mutable object is copy and referenced by variable *cache* define inside of the function shared closure. It forms what I call a *closure protected copy of a mutable object*[^6].

You must be careful in using this idiom because *getattr* return the value of cache by doing a deep copy. This operation could have a significant performance impact on large objects!

{% highlight python %}
from copy import deepcopy

def SpaceFrozenValues():
    cache = {}
    def setattr(self, name, value):
        nonlocal cache
        if name in cache:
            raise AttributeError(
                "Cannot reassign members"
            )
        cache[name] = deepcopy(value)
    def getattr(self, name):
        nonlocal cache
        if name not in cache:
            raise AttributeError(
                "Object has no attribute '{}'".format(name)
            )
        return deepcopy(cache[name])
    cls = type('SpaceFrozenValues', (),{
        '__getattr__': getattr,
        '__setattr__': setattr
    })
    return cls()

fv = SpaceFrozenValues()
print(fv.x) # AttributeError: Object has no attribute 'x'
fv.x = 2 # bind attribute x
print(fv.x) # print "2"
fv.x = 3 # raise "AttributeError: Cannot reassign members"
fv.y = {'name': 'y', 'value': 2} # bind attribute y
print(fv.y) # print "{'name': 'y', 'value': 2}"
fv.y['name'] = 'yprime' # you can try to change mutable objects
print(fv.y) # print "{'name': 'y', 'value': 2}"
fv.y = {} # raise "AttributeError: Cannot reassign members"
{% endhighlight %}

## A constant space (ConstantSpace)

This idiom is an immutable namespace of constant variables or **ConstantSpace**. It is a combination of awesomely simple Jon Betts' answer in stackoverflow[^7] with a class factory[^3].

{% highlight python %}
def ConstantSpace(**args):
    args['__slots__'] = ()
    cls = type('ConstantSpace', (), args)
    return cls()

cs = ConstantSpace(
    x = 2,
    y = {'name': 'y', 'value': 2}
)

print(cs.x) # print "2"
cs.x = 3 # raise "AttributeError: 'ConstantSpace' object attribute 'x' is read-only"
print(cs.y) # print "{'name': 'y', 'value': 2}"
cs.y['name'] = 'yprime' # mutable object can be changed
print(cs.y) # print "{'name': 'yprime', 'value': 2}"
cs.y = {} # raise "AttributeError: 'ConstantSpace' object attribute 'x' is read-only"
cs.z = 3 # raise "AttributeError: 'ConstantSpace' object has no attribute 'z'"
{% endhighlight %}

## A frozen space (FrozenSpace)

This idiom is an immutable namespace of frozen variables or **FrozenSpace**. It is derived from the previous pattern by making each variable a *protected property by closure*[^6] of the generated **FrozenSpace** class.

{% highlight python %}
from copy import deepcopy

def FreezeProperty(value):
    cache = deepcopy(value)
    return property(
        lambda self: deepcopy(cache)
    )

def FrozenSpace(**args):
    args = {k: FreezeProperty(v) for k, v in args.items()}
    args['__slots__'] = ()
    cls = type('FrozenSpace', (), args)
    return cls()

fs = FrozenSpace(
    x = 2,
    y = {'name': 'y', 'value': 2}
)

print(fs.x) # print "2"
fs.x = 3 # raise "AttributeError: 'FrozenSpace' object attribute 'x' is read-only"
print(fs.y) # print "{'name': 'y', 'value': 2}"
fs.y['name'] = 'yprime' # try to change mutable object
print(fs.y) # print "{'name': 'y', 'value': 2}"
fs.y = {} # raise "AttributeError: 'FrozenSpace' object attribute 'x' is read-only"
fs.z = 3 # raise "AttributeError: 'FrozenSpace' object has no attribute 'z'"
{% endhighlight %}


## References

[^1]: [How do I create a constant in Python?](https://stackoverflow.com/questions/2682745/how-do-i-create-a-constant-in-python).
[^2]: [Constants in Python (Python Recipe)](http://code.activestate.com/recipes/65207-constants-in-python/)
[^3]: [What are the measures to call a python code a policy based design?](https://stackoverflow.com/questions/57365189/what-are-the-measures-to-call-a-python-code-a-policy-based-design)
[^4]: [Policy-based design in Python](https://baites.github.io/computer-science/patterns/2019/08/02/policy-based-design-in-python.html)
[^5]: [Are closures trivial? (see all blog of the series)](https://baites.github.io/computer-science/idioms/2017/12/11/are-closures-trivial.html)
[^6]: [Made up patterns with closures](https://baites.github.io/computer-science/idioms/2017/12/04/made-up-patterns-with-closures.html)
[^7]: [Jon Betts answered in stackoverflow](https://stackoverflow.com/a/23274028/11875212)
