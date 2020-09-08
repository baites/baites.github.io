---
layout: post
title: "Class factory and dataclass in python"
date: 2020-09-08 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

* TOC
{:toc}

# Introduction

This post continues with using a class factory in python, a powerful idiom that I have seen discussed often. I extensively used this idiom in previous blogs about policy-based design in python.

* [Policy-based design in python]({% post_url 2019-08-02-policy-based-design-in-python %})
* [Mixin and policy-based design in python]({% post_url 2019-10-22-mixin-and-policy-based-designs-in-python %})

In this blog, I will show how to use a class factory to create a new style for defining classes in python. This style is more conducent to express types when decomposing a problem using object-oriented approaches[^1] typically found in typed strongly-typed language[^2].

# The problem

Let say that you have a problem that requires a simple **Author** type with a name and desc (short for description) fields. Naively, I can do this using the following python code:

{% highlight python %}
class Author:
    def __init__(self, name: str, desc: str):
        self.name = name
        self.desc = desc
{% endhighlight %}

**Note**: In the previous example, I am using type hints[^3], a relatively recent addition to python[^4]. Python documentation is a good source on how to use these hints[^5].

My issue with this example is the following: I need to use the class constructor to define the object data's basic structure. Using type hints, now it is possible to declare the intended type for each of the fields. However, this definition comes as type hints for the constructor arguments rather than the actual object fields.

Things become more complicated if you want to enforce some protection to the field values. It is common in some object-oriented approaches that field values should be those provided during the object instantiation. In the previous example, the code user can edit field values at any time. One way to freeze the field values is to define them as the class's property without a 'setter' or 'delattr' function associated with it.

{% highlight python %}
class Author:
    def __init__(self, name: str, desc: str):
        self._name = name
        self._desc = desc

    @property
    def name(self) -> str:
        return self._name

    @property
    def desc(self) -> str:
        return self._desc
{% endhighlight %}

In this example, any attempt to redefine a field's value after instantiation will raise **AttributeError** exception. This solution works at the cost of having a somewhat convoluted syntax to define just an elementary class[^6].

# Solution using a class factory

Using a class factory I call **CreateClass** you can write previous two examples using the following notation:

{% highlight python %}
CreateClass('Author', (
    'name',
    'desc'
))
{% endhighlight %}

or for frozen field version

{% highlight python %}
CreateClass('Author', (
    'name',
    'desc'
), frozen=True)
{% endhighlight %}

The code class factory is the following:

{% highlight python %}
def CreateClass(name, fields, parents=(), frozen=False):
    """Create a base class with a given fields and parents."""

    def getter(field):
        return lambda self: getattr(self, '_{}'.format(field))

    def setter(field):
        return lambda self, value: setattr(self, '_{}'.format(field), value)

    def deleter(field):
        return lambda self: delattr(self, '_{}'.format(field))

    def init(self, **kwargs):
        for field in fields:
            if field not in kwargs:
                raise ValueError(
                    'Missing initial value for argument "{}"'.format(field)
                )
            setattr(self, '_{}'.format(field), kwargs[field])

    members = {'__init__': init}
    for field in fields:
        if frozen:
            members[field] = property(
                getter(field)
            )
        else:
            members[field] = property(
                getter(field),
                setter(field),
                deleter(field)
            )

    globals()[name] = type(name, parents, members)
    return globals()[name]
{% endhighlight %}

**Note**: [ClassFactory.py](https://github.com/baites/examples/blob/master/idioms/python/ClassFactory.py) shows a full working example of the code.

Still, I am not very happy with the solution because of the following reasons:

* Syntax is very different from the traditional one using the *class* keyword.
* Type hints are not supported in this example.
* The fact I have to write a custom made factory.

Likely for me, python developers were listening to my prayers and created python data classes.

# Solution using data class

Data classes are a relatively recent addition to python three define in PEP-557[^7]. I will not discuss all the features that are part of the data classes. You can read about it at your own leisure[^8]. Instead, I will show how to implement my simple examples using the **@dataclass** class decorator.

In the first example, I can write it as follow.

{% highlight python %}
@dataclass
class Author:
    name: str
    desc: str
{% endhighlight %}

and the second example using frozen fields

{% highlight python %}
@dataclass(frozen=True)
class Author:
    name: str
    desc: str
{% endhighlight %}

**Note**: [PythonDataclass.py](https://github.com/baites/examples/blob/master/idioms/python/PythonDataclass.py) shows a full working example of the code.

# Conclusion

I use a class factory in an attempt to improve python syntax to define classes with fields. However, in the process, I learn about python data classes. As far as I can read in the code, python data classes use a class decorator to decorate a user-defined class with fields. It is a beautiful solution to speed up the development of code with a strong object-oriented flavor.

# References

[^1]: You can see as an example of this approach the excellent educative course [Grokking the Object-Oriented Design Interview](https://www.educative.io/courses/grokking-the-object-oriented-design-interview).

[^2]: [Magic lies here - Statically vs Dynamically Typed Languages](https://android.jlelse.eu/magic-lies-here-statically-typed-vs-dynamically-typed-languages-d151c7f95e2b).

[^3]: [PEP 483 -- The Theory of Type Hints](https://www.python.org/dev/peps/pep-0483/).

[^4]: [PEP 484 -- Type Hints](https://www.python.org/dev/peps/pep-0484/).

[^5]: [typing — Support for type hints](https://docs.python.org/3/library/typing.html)

[^6]: Imaging doing this in a technical interview on a whiteboard. How many silly syntax mistakes can occur you can make that would like rather bad for you.

[^7]: [PEP 557 -- Data Classes](https://www.python.org/dev/peps/pep-0557/)

[^8]: [The Ultimate Guide to Data Classes in Python 3.7](https://realpython.com/python-data-classes/) or [dataclasses — Data Classes](https://docs.python.org/3/library/dataclasses.html).
