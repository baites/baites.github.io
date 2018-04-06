---
layout: post
title: "Python Singletons, the Borg, and the MetaBorg"
date: 2018-05-14 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

## Singletons

Study pattern design for high-level languages like javascript or python is a weird exercise.  This feeling originates in the intuition that there is a lot of these patterns that although necessary in C++, they seems to be almost invisible in python for example. This intuition prove to be profound resulting in a series of discussions by very smart people about what the role design pattern play in high-level languages[^1].

Singleton is one of those patterns that seems to be persistent pattern amount all the different languages[^2]. It is also a pattern that a lot of people hates[^3], more on that in a moment. However, this pattern is one of those things that people expect you should know if you are working on anything related to coding or programming.

In this post, I would like to discuss singletons in python inspired by the following reference[^4]. Singleton pattern can be defined as *ensure a class only has one instance, and provide a global point of access it*[^5]. However, I think most of the issues with singletons arises when defining how they should behave at initialization time and when using inheritance.

I implemented, three types of singletons in python with based on mostly reference [^4], and I selected them because[^6]:

* they are patterns that make traditional classes into a singleton-like object;
* they behave in different ways when using with inheritance;
* they also have different behavior at initialization.

## Class variable singleton

### Implementation

Class variable singleton is one of the most common singleton implementations. The idea is to create a class that by inheritance make a user-defined class a singleton. I show an example of this pattern next.

{% highlight python %}
class ClassVariableSingleton(object):
    _instance = None
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super().__new__(cls)
        return cls._instance

# Class A is now a singleton
class A(ClassVariableSingleton):
    ...
{% endhighlight %}

The implementation relies on having a class variable named *\_intance* and in redefining *\_\_new\_\_()* function in the parent **ClassVariableSingleton**. When the user initializes an instance of child class **A**, the call to *\_\_new\_\_(...)* is intercepted, creating a new instance if only if class variable *\_instance* points to **None**. In this case, the function points *\_instance* to the newly created instance and returns a reference to it. After this initialization, a reference to the first instance is always returned upon any other initialization of **A**.

### Initialization

One important thing to notice with this implementation is that I implement the *global point to access* the instance by reusing python syntax for object instantiation. However, this brings one issue: although every apparent instantiation returns the same instance, the constructor *A.\_\_init\_\_(...)* is executed against this instance before it is returned. We can say therefore that the instance is re-initialized every time we access it. Here it is a schematic example of the re-initialization:

{% highlight python %}
# Class A is now a singleton
class A(ClassVariableSingleton):
    def __init__(self, value):
        self.value = value
# Instance is created
x = A('x')
# Initial instance is return after running A.__init__(...)
y = A('y')
# Print value
print('x.value = {}'.format(x.value))
print('y.value = {}'.format(y.value))
# x.value = y
# y.value = y
{% endhighlight %}

This issue is regarded as undesirable because it is usually understood that instance should be initialized only once. By the way, this example can be found [ClassVariableSingleton example from my repo](https://github.com/baites/examples/blob/master/patterns/python/singleton/ClassVariableSingleton.py#L59) and execute it using

{% highlight bash %}
./ClassVariableSingleton.py I
Initialize A twice
x.value = y
y.value = y
{% endhighlight %}

### Inheritance

Let's assume I define a child class **B** of **A** like shown below.

{% highlight python %}
# Class B child of A
class B(A):
    def __init__(self, value):
        self.value = value
{% endhighlight %}

Do I get the same instance when calling *B(...)* than when calling *A(...)*? The answer to the questions is *it depends on the order of the call*.

If I instantiate the parent class *A(...)* first, both **A** and **B** will share the same value of the class variable *_instance*. Therefore, any call to *B(...)* will return the same as calling *A(...)* again, meaning *B(...)* will return the same instance as I show in next example.

{% highlight python %}
# Instance is created
x = A('x')
# Initial instance is return after running B.__init__(.)
y = B('y')
# Print value
print(repr(x))
print(repr(y))
# <__main__.A object at 0x7f113ec78668>
# <__main__.A object at 0x7f113ec78668>
{% endhighlight %}

**Note**: this example cab be run `./ClassVariableSingleton.py A`.

However, if I instantiate the child class *B(...)* first, the value of the class variable *A._instance* will be still **None**. Therefore, calling *A(...)* will return a new instance as represented in the following example.

{% highlight python %}
# Instance is created
y = B('y')
# A new instance is created
x = A('x')
# Print value
print(repr(y))
print(repr(x))
# <__main__.B object at 0x7f849c501668>
# <__main__.A object at 0x7f849c501630>
{% endhighlight %}

**Note**: this example cab be run `./ClassVariableSingleton.py B`.

This issue is also is seen as a very undesirable due to the fact singleton behavior depends on the order of when parent or child classes are instantiated. This could produce undefined program behavior if for example singleton parent and child are initialized on different threads.

## Metaclass singleton

It is possible to avoid calling the constructor of the singleton more than once for the same instance and preserved in essence the previous pattern and shown in the following example.

{% highlight python %}
class MetaclassSingleton(type):
    _instance = None
    def __call__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super().__call__(*args, **kwargs)
        return cls._instance
# Class A is now a singleton
class A(metaclass=MetaclassSingleton):
    def __init__(self, value):
        self.value = value
{% endhighlight %}

This singleton implementation does not transfer the singleton feature by inheritance. Instead, it declares the user class as belonging to a singleton metaclass type that redefines the *\_\_call\_\_(...)* function. As a result, the first call to *A(...)* returns a new instance created calling the default *\_\_call\_\_(...)* that, in turn, it calls the constructor *A.__init__(...)*.  Calling *A(...)* for a second time returns the first instance without running its default *\_\_call\_\_()* and therefore **avoiding re-initializing the instance again**.

**Note**: this example cab be run `./MetaclassSingleton.py I` from my [repo](https://github.com/baites/examples/blob/master/patterns/python/singleton/MetaclassSingleton.py#L61). When using this singleton with inheritance we obtain the same behavior as class variable singleton, check for example `./MetaclassSingleton.py A` and `./MetaclassSingleton.py B`.

## The Borg

A Borg is another popular pattern created and promoted by Alex Martelli[^7]. A Borg is not a singleton, however, for most practical purposes it behaves like one. This pattern is generally implemented using inheritance to transform a standard class in a singleton-like type. Below you can find my distilled version of this pattern.

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


### References

[^1]: See, for example, this [stack exchange entry](https://softwareengineering.stackexchange.com/questions/157943/are-there-any-design-patterns-that-are-unnecessary-in-dynamic-languages-like-pyt).

[^2]: [Wikipedia entry](https://en.wikipedia.org/wiki/Singleton_pattern).

[^3]: [What is so bad about singletons?](https://stackoverflow.com/questions/137975/what-is-so-bad-about-singletons)

[^4]: [The singleton](http://python-3-patterns-idioms-test.readthedocs.io/en/latest/Singleton.html)

[^5]: [Design Patterns: Element of Reusable Object-Oriented Software.](https://en.wikipedia.org/wiki/Design_Patterns)

[^6]: I you work with C++ I highly recommend chap 6 of [Modern C++ design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design).

[^7]: [SINGLETON? WE DON'T NEED NO STINKIN' SINGLETON: THE BORG DESIGN PATTERN (PYTHON RECIPE)](http://code.activestate.com/recipes/66531-singleton-we-dont-need-no-stinkin-singleton-the-bo/)
