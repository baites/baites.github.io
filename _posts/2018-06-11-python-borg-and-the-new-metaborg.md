---
layout: post
title: "Python Borg, and the new MetaBorg"
date: 2018-06-11 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

This is the second post of a series dedicated to discuss singleton-like patterns in python. As a reference you can find the first post at

* [Python singletons]({% post_url 2018-05-28-python-singletons %})

## The Borg

A Borg is popular pattern created and promoted by Alex Martelli[^7]. A Borg is not a singleton, however, for most practical purposes it behaves like one. This pattern is generally implemented using inheritance to transform a standard class in a singleton-like type. Below you can find my distilled version of this pattern.

{% highlight python %}
class Borg(object):
    _state = {}
    def __new__(cls, *args, **kwargs):
        instance = super().__new__(cls, *args, **kwargs)
        instance.__dict__ = cls._state
        return instance
# Class A is now a Borg
class A(Borg):
    ...
{% endhighlight %}

This version of the Borg relies upon redefining *\_\_new\_\_(...)* function as it is the case of a class variable singleton. However, in a Borg, every instantiation of the child class **A** returns a **different instance** of **A** but all of them with a **shared state** pointed by *\_state* class variable. This means that all the instances of **A**, although individually different, *belong to the Borg collective A* (and resistance is futile)!

The Borg pattern has a similar drawback/feature as the class variable singleton, that is that the instance state is re-initialized. This process changes the state of the not only the returned instance but of the whole Borg collective, for example, check this Borg example `./Borg.py I` from my [repo](https://github.com/baites/examples/blob/master/patterns/python/singleton/Borg.py#L61).

Inheritance in the Borg works differently than from previous two singletons. For the Borg, there is not differences between parent and child classes. Assuming you have a parent class **A** and its child **B** then we always obtain the same shared state regardless of the order on how **A** or **B** were initialized, see for example the results of running `./Borg.py A` and `./Borg.py B`.

## The MetaBorg

This pattern is my invention. As I usually do, here it is a warning that is it likely somebody already did it before. However, I give you my word that I created this pattern all by myself.

The questions I tried to answer is it possible to combine the single initialization of the Metaclass singleton with the Borg advantages when using inheritance?

The answer turned out to be yes, and this is how the MetBorg was born. Without further overdue here it is the pattern.

{% highlight python %}
class MetaBorg(type):
    _state = {"__skip_init__": False}
    def __call__(cls, *args, **kwargs):
        if cls._state['__skip_init__']:
            cls.__check_args(*args, **kwargs)
        instance = object().__new__(cls, *args, **kwargs)
        instance.__dict__ = cls._state
        if not cls._state['__skip_init__']:
            instance.__init__(*args, **kwargs)
            cls._state['__skip_init__'] = True
        return instance
class A(metaclass=MetaBorg):
...
{% endhighlight %}

The idea is the following. The first time the user instantiates the class **A**; a new instance is created with a shared state as it is the case for the Borg. In this first call, the MetaBorg also set the value of shared state by running *A.\_\_init\_\_(...)*. After that, any other instantiation of **A** returns a new instance with the shared state but without re-initializing, its value in analogy to metaclass singleton, see example below.

{% highlight python %}
class A(metaclass=MetaBorg):
    def __init__(self, value):
        self.value = value
x = A('x')
y = A()
print('x.value = {}'.format(x.value))
print('y.value = {}'.format(y.value))
# x.value = x
# y.value = x
{% endhighlight %}

Here it is the [full implementation of this pattern](https://github.com/baites/examples/blob/master/patterns/python/singleton/MetaBorg.py). I added a check to verify that any instantiation after the first should expect no arguments to enforce the idea they only provide access to the shared state. MetaBorg behavior relative inheritance is the same a the Borg without the re-initilization step, see for example the results of running `./MetaBorg.py A` and `./MetaBorg.py B`.

### References

[^1]: See, for example, this [stack exchange entry](https://softwareengineering.stackexchange.com/questions/157943/are-there-any-design-patterns-that-are-unnecessary-in-dynamic-languages-like-pyt).

[^2]: [Wikipedia entry](https://en.wikipedia.org/wiki/Singleton_pattern).

[^3]: [What is so bad about singletons?](https://stackoverflow.com/questions/137975/what-is-so-bad-about-singletons)

[^4]: [The singleton](http://python-3-patterns-idioms-test.readthedocs.io/en/latest/Singleton.html)

[^5]: [Design Patterns: Element of Reusable Object-Oriented Software.](https://en.wikipedia.org/wiki/Design_Patterns)

[^6]: I you work with C++ I highly recommend chap 6 of [Modern C++ design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design).

[^7]: [SINGLETON? WE DON'T NEED NO STINKIN' SINGLETON: THE BORG DESIGN PATTERN (PYTHON RECIPE)](http://code.activestate.com/recipes/66531-singleton-we-dont-need-no-stinkin-singleton-the-bo/)
