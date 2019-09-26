---
layout: post
title: "Policy-based and mixin design in python"
date: 2029-09-16 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

* TOC
{:toc}

## introduction

This post is supporting material for an answer I give to my own original question in stackoverflow:

[What are the measures to call a Python code a policy-based design?](https://stackoverflow.com/questions/57365189/what-are-the-measures-to-call-a-python-code-a-policy-based-design)

The answer is the product of what I learn based my own research and some of the comments from stackoverflow.

## Design requirements and implementations

### Requirement

Design a Python module with so users can create classes with new behavior and interfaces by inheriting from a predefine set of classes. If the module is correctly design, this approach provide a large number of classes available to the users based on all possible ways classes can be combined into new ones.

This requirement can be implemented using mixin and policy-based implementations.

### Mixin implementation

Mixin implementation is defined as follow[^1]:

* Module classes are divided between mixin and base classes.
* Mixin classes implement modifications to the behavior or interface of a base class.
* Users create a new class from by combining one or more mixin(s) with base classes by inheritance.

{% highlight python %}
class Mixin1Class:
    """Implementation of some Mixin1 class."""
class Mixin2Class:
    """Implementation of some Mixin2 class."""
...
class BasedClass:
    """Implementation of based class."""

# End user creating new class
class NewClass(Mixin1Class, [Mixin2Class, ...], BasedClass):
    pass
{% endhighlight %}

References:
* [Wikipedia: Mixin](https://en.wikipedia.org/wiki/Mixin).
* [StackOverflow answer about mixin](https://stackoverflow.com/a/547714/11875212).

### Policy-based implementation

Policy-based implementation is defined as follow:

* Module classes are divided between policy and host classes.
* Policy classes implement modifications to the behavior or interface of the host.
* Host classes are defined withing class factories i.e. function that return type objects.
* Users invoke the creation of new classes using class factories.
* Policy classes are passed as argument to the class factory.
* Withing the class factory, the host class is created with all the policy classes as its parents.

{% highlight python %}
class Policy1Class:
    """Implementation of some Policy1 class."""
class Policy2Class:
    """Implementation of some Policy2 class."""
...
def HostClassFactory(Policy1, Policy2=Policy2Class, ...):
    """Create a HostClass and return it."""
    class HostClass(Policy1, Policy2, ...):
        """Concrete implementation of the host class."""
    return HostClass

# End user invoking new class
NewClass = HostClassFactory(Policy1Class, [Policy2Class,...])
{% endhighlight %}

References:

* [Wikipedia: Modern C++ Design, Policy-based design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design#Policy-based_design).
* [My question in stackoverflow](https://stackoverflow.com/q/57365189/11875212).
* [My technical blog: Policy-based design in python](https://baites.github.io/computer-science/patterns/2019/08/02/policy-based-design-in-python.html)

### Comparison between implementations

Here a list of the differences between approaches:

* The relationship between classes is not the same

<center>
<p>
  <img src="{{ site.url }}/assets/images/mixin-class-diagram.svg" width="53%" />
  <img src="{{ site.url }}/assets/images/policy-based-class-diagram.svg" width="43%" />
</p>
<p>Class diagram for mixin (left) and policy-based class (right) approaches.</p>
</center>

## References

[^2]: [Modern C++ Design: Generic Programming and Design Patterns Applied](https://www.amazon.com/Modern-Design-Generic-Programming-Patterns/dp/0201704315)

[^3]: [Wikipedia: Strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern)

[^4]: [Policy based design in Python](https://stackoverflow.com/questions/26533073/policy-based-design-in-python)

[^5]: Example in C++ example in [Wikipedia: Modern C++ Design, Policy-based design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design#Policy-based_design). In the Python example, I am using the Python convention that one underscore implies a protected object variable. I am also doing the example in Finnish instead of German just for fun!

[^6]: [See Python Dependency Injection by Alex Martelli](http://www.aleax.it/yt_pydi.pdf).

[^7]: Interval trees in Chapter 14, page 348 of [Introduction to Algorithms, 3rd edition](https://www.amazon.com/Introduction-Algorithms-3rd-MIT-Press/dp/0262033844).

[^8]: [Wikipedia: With great power comes great responsibility](https://en.wikipedia.org/wiki/With_great_power_comes_great_responsibility)
