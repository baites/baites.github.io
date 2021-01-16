---
layout: post
title: "Mixin and policy-based design in python"
date: 2019-10-22 06:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns python-policy-based-mixins-series
---

| This blog is part of a series dedicated to policy-based and mixins approaches in python. [In the Series page you can find all the posts of the series]({{ 'series#python-policy-based-mixins-series' | relative_url}} ). |

* TOC
{:toc}

# Introduction

This post is supporting material for an answer I give to my original question in StackOverflow:

* [What are the measures to call a Python code a policy-based design?](https://stackoverflow.com/questions/57365189/what-are-the-measures-to-call-a-python-code-a-policy-based-design)

The answer is the product of what I learn based on my research and some comments from StackOverflow.

# Design requirements and implementations

## Requirement

Design a Python module such users can create classes with new behavior and interfaces by inheriting from a predefined set of classes. This approach provides a large number of classes available to the users based on all possible ways they can be combined into new ones.

This requirement can be implemented using mixin and policy-based implementations.

## Mixin implementation

Mixin implementation is defined as follow:

* Module classes are divided between mixin and base classes.
* Mixin classes implement modifications to the behavior or interface of a base class.
* Users create a new class by combining one or more mixin(s) with base classes by inheritance.

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

**References:**

* [Wikipedia: Mixin](https://en.wikipedia.org/wiki/Mixin).
* [StackOverflow answer about mixin](https://stackoverflow.com/a/547714/11875212).

## Policy-based implementation

Policy-based implementation is defined as follow:

* Module classes are divided between policy and host classes.
* Policy classes implement modifications to the behavior or interface of the host.
* Host classes are defined withing class factories i.e., a function that returns type objects.
* Users invoke the creation of new class using *class factories*.
* Policy classes are passed as arguments to the class factory.
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

**References:**

* [Wikipedia: Modern C++ Design, Policy-based design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design#Policy-based_design).
* [My question in stackoverflow](https://stackoverflow.com/q/57365189/11875212).
* [My technical blog: Policy-based design in python](https://baites.github.io/computer-science/patterns/2019/08/02/policy-based-design-in-python.html)

## Comparison between implementations

Here a list of the differences between approaches:

* The relationship between classes is not the same affecting the Python's Method Resolution Order or MRO, see figure below.
* The mixin's base classes are defined or instantiated when the user creates the new class.
* However, policy-based host class definition is delayed until the user calls the factory function.
* It is possible to provide default policy classes, but you cannot have mixin default classes.

<center>
<p>
  <img src="{{ site.url }}/assets/images/mixin-class-diagram.svg" width="53%" />
  <img src="{{ site.url }}/assets/images/policy-based-class-diagram.svg" width="43%" />
</p>
<p>Class diagram for mixin (left) and policy-based class (right) approaches.</p>
</center>

# Improvements

## Adding mixin defaults with class factory decorators

Reusing the *class factory* pattern within a class decorator, we can improve the mixin pattern to allow for default mixin classes. I implemented the decorator as it is shown below

{% highlight python %}
def mixinbase(*defaults):
    def decorator(baseclass):
        def decoration(*mixins):
            if len(mixins) == 0:
                if len(defaults) == 0:
                    raise ValueError('No default mixins available.')
                mixins = defaults
            name = '{}('.format(baseclass.__name__)
            for mixin in mixins[:-1]:
                name += '{},'.format(mixin.__name__)
            name += '{})'.format(mixins[-1].__name__)
            return type(name, mixins+(baseclass,), {})
        return decoration
    return decorator
{% endhighlight %}

The function **mixinbase** is a parametric decorator that returns a class **decorator** with the *default* variable within its closure. The class decorator is a function that takes as input a class and returns the **decoration** function with *baseclass* within its closure. This **decoration** function is a class factory that takes as input a collection of *mixins*. If the user calls the **decoration** with some input mixins, a new type object (a.k.a. a class) is returned using those *mixins* and closure's *baseclass* as its parents. However, if the user omits to input any mixins, then the returned class has as parents the class collection in closure's *defaults* plus *baseclass*.

Below I show an example on how to use this decorator:

{% highlight python %}
class PrintOutput:
    """Implement print output mixin."""
    def _output(self, message):
        print(message)

class SaveOutput:
    """Implement save output mixin."""
    def set_filename(self, filename):
        self.filename = filename
    def _output(self, message):
        with open(self.filename, 'w') as file:
            file.write(message)

@mixinbase(PrintOutput)
class HelloWorld:
    """Creates a host class."""
    def run(self):
        """Print message."""
        self._output('Hello world!')


PrintHelloWorld = HelloWorld()
print(PrintHelloWorld) # print: <class '__main__.HelloWorld(PrintOutput)'>

hw = PrintHelloWorld()
hw.run() # print "Hello World!"

PrintHelloWorld = HelloWorld(PrintOutput)
print(PrintHelloWorld) # <class '__main__.HelloWorld(PrintOutput)'>
hw = PrintHelloWorld()
hw.run() # print "Hello World!"

SaveHelloWorld = HelloWorld(SaveOutput)
print(SaveHelloWorld) # <class '__main__.HelloWorld(SaveOutput)'>
hw = SaveHelloWorld()
hw.set_filename('output.txt')
hw.run() # save "Hello World!" in output.txt
{% endhighlight %}

Find a full working example of this code in my [github account](https://github.com/baites/examples/blob/master/idioms/python/MixinDesign.py).

## Decorator approach to policy-based design

It is possible to use the previous mixin decorator approach to emulate a policy-based implementation that does not delay the instantiation of the host class. It is also aesthetically more appealing because the user does not need to define the host class within a class factory.

This implementation is based on the following decorator:

{% highlight python %}
def hostclass(*defaults):
    def decorator(host):
        def decoration(*policies):
            if len(policies) == 0:
                if len(defaults) == 0:
                    raise ValueError('No default policies available.')
                policies = defaults
            name = '{}('.format(host.__name__)
            for policy in policies[:-1]:
                name += '{},'.format(arg.__name__)
            name += '{})'.format(policies[-1].__name__)
            return type(name, (host,)+policies,{})
        return decoration
    return decorator
{% endhighlight %}

This decorator is identical to the mixin decorator (see the previous section) with the only difference the first parent is the host class follow by the policy class. This case is in contrast with the mixin, where the base class is the last parent.

Here it is an example on how to use this decorator:

{% highlight python %}
class PrintOutput:
    """Implement print output mixin."""
    def _output(self, message):
        print(message)

class SaveOutput:
    """Implement save output mixin."""
    def set_filename(self, filename):
        self.filename = filename
    def _output(self, message):
        with open(self.filename, 'w') as file:
            file.write(message)

@hostclass(PrintOutput)
class HelloWorld:
    """Creates a host class."""
    def run(self):
        """Print message."""
        self._output('Hello world!')

PrintHelloWorld = HelloWorld()
print(PrintHelloWorld) # <class '__main__.HelloWorld(PrintOutput)'>
hw = PrintHelloWorld()
hw.run() # print "Hello World!"

PrintHelloWorld = HelloWorld(PrintOutput)
print(PrintHelloWorld) # <class '__main__.HelloWorld(PrintOutput)'>
hw = PrintHelloWorld()
hw.run() # print "Hello World!"

SaveHelloWorld = HelloWorld(SaveOutput)
print(SaveHelloWorld) # <class '__main__.HelloWorld(SaveOutput)'>
hw = SaveHelloWorld()
hw.set_filename('output.txt')
hw.run() # save "Hello World!" in output.txt
{% endhighlight %}

Find a full working example of this code in my [github account](https://github.com/baites/examples/blob/master/idioms/python/PolicyBasedDecoratorEx1.py).

## Difference between these two class decorators

The previous two decorators look almost identical except for the class's MRO is not the same. For example, here it is an example I showed in StackOverflow that cannot be done either with traditional or decorator mixin as I defined above:

{% highlight python %}
class InputMessage:
    """Generate the message."""
    def run(self):
        return 'hello world'

def AddPrefix(Input):
    """Add a prefix."""
    class _(Input):
        def set_prefix(self, prefix):
            self._prefix = prefix
        def run(self):
            return self._prefix + super().run()
    return _

def AddSuffix(Input):
    """Add a suffix."""
    class _(Input):
        def set_suffix(self, suffix):
            self._suffix = suffix
        def run(self):
            return super().run() + self._suffix
    return _

def PrintOutput(Input):
    """Print message."""
    class _(Input):
        def run(self):
            print(super().run())
    return _

PrintPrefixSuffixMessage = PrintOutput(
    AddSuffix(AddPrefix(InputMessage))
)
message = PrintPrefixSuffixMessage()
message.set_prefix('Victor says: ')
message.set_suffix(' and goodbye!')
message.run() # print: Victor says: hello world and goodbye!
{% endhighlight %}

The example shows how to create a composition by using a host class as a policy class for another host class. The composition has to start from an initial policy class and can continue as long the user requires. This approach needs that the MRO is such that the call to **super()** provides access to the members the proper *previous* policy. It is possible to write this using policy-based design decorator as:

{% highlight python %}
class InputMessage:
    def run(self):
        return 'hello world'

@hostclass()
class AddPrefix:
    def set_prefix(self, prefix):
        self._prefix = prefix
    def run(self):
        return self._prefix + super().run()

@hostclass()
class AddSuffix:
    def set_suffix(self, suffix):
        self._suffix = suffix
    def run(self):
        return super().run() + self._suffix

@hostclass()
class PrintOutput:
    def run(self):
        print(super().run())


PrintPrefixSuffixMessage = PrintOutput(
    AddSuffix(AddPrefix(InputMessage))
)
message = PrintPrefixSuffixMessage()
message.set_prefix('Victor says: ')
message.set_suffix(' and goodbye!')
message.run() # print: Victor says: hello world and goodbye!
{% endhighlight %}

Find a full working example of this code in my [github account](https://github.com/baites/examples/blob/master/idioms/python/PolicyBasedDecoratorEx2.py). Both approaches to policy-based design are functionally equivalent. However, they do not share the same underlying class hierarchy.

<center>
<p>
  <img src="{{ site.url }}/assets/images/class-composition-diagram.svg" width="110%" />
</p>
<p>Class diagram for the two policy-based design approaches.</p>
</center>

# Conclusion

Mixin and policy-based design are two implementations of an abstract pattern to develop customizable classes in Python modules. In the process of research these approaches and stumbled with a simple pattern, I called *class factory*. The class factory seems to be an incredibly versatile idiom that I have not seen discussed much. I may have a few more things to say about class factories, perhaps I would do so in future blogs.
