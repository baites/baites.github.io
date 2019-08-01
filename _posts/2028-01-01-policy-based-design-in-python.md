---
layout: post
title: "Policy-based design in python"
date: 2028-01-01 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

## Policy-based design

Policy-based design is an approach[^1] pioneer as far as I know in the book Modern C++ Design by Andrei Alexandrescu[^2]. Most people believe that this idiom can only be implemented in C++ because it looks like as a compile-time analog of Strategy pattern that works at runtime[^3]. As a result, this pattern may not exist for interpreted languages such as python[^4]. Before I move forward with this post, I need to clarify what I call policy-based design.

For me, the goal of policy-based design is to provide a collection of classes where their inheritance relationships are not entirely defined in advance. It is developer responsibility to assign those relationships based on the project requirements. A developer mostly establishes those relationships at compile time or run time depending on the language. I am using the expression *at coding time* to express any of the two previous scenarios, i.e. coding time = compile or run time.

In the following section, I am providing the definitions to accomplish this in Python. When possible, I will show what I think is the closest equivalent on C++ as reference.

## Policy and host classes

Under this pattern, classes are divided between *policy classes* and *host classes*. Policy classes are classes that implement a policy to modify the behavior or the interface of a host class by inheritance. For example, here its Python code for the *HelloWorld* example found in the Wikipedia entry[^5].

{% highlight python %}
# Example of policy-based design

# Define policy classes

class PrintOutput:
    """Implement output policy."""
    def _output(self, message):
        print(message)

class EnglishLanguage:
    """Implement english message."""
    def _message(self):
        """Return message"""
        return 'Hello world!'

class FinnishLanguage:
    """Implement english message."""
    def _message(self):
        """Return message"""
        return 'Hei maailma!'

# Define host class

def HelloWorld(Language, Output=PrintOutput):
    """Creates a host class."""
    class _(Language, Output):
        """Implements class affected by the policy."""
        def run(self):
            """Print message."""
            self._output(self._message())
    return _

HelloWorldEnglish = HelloWorld(EnglishLanguage)
hw = HelloWorldEnglish()
hw.run() # prints "Hello World!"

HelloWorldFinnish = HelloWorld(FinnishLanguage)
hw = HelloWorldFinnish()
hw.run() # prints "Hei maailma!"
{% endhighlight %}
**Note**: find full example in my [github](https://github.com/baites/examples/blob/master/idioms/python/PolicyBasedDesignEx1.py).

The classes **EnglishLanguage** and **FinnishLanguage** are the policy classes that implement the *"Hello World!"* messages in different languages. The class **PrintOutput** is at the moment the only class that implements an output policy for the message. Each of these policy classes affects the host class **HelloWorld** throughout inheritance at coding time. It is possible, therefore, for a developer to customize the **HelloWorld** class for English or Finnish, and also for a particular output class based on the program requirements.

## Strategy and Dependency Injection

The previous code can be implemented using a Strategy or Dependency Injection pattern in Python[^6] if we are only interesting of changing the behavior of the **HelloWorld**:

{% highlight python %}
# Example of dependency injection

# Define possible dependencies

def PrintOutput(message):
    """Implement output dependency."""
    print(message)

def EnglishLanguage():
    """Implement english message."""
    return 'Hello world!'

def FinnishLanguage():
    """Implement english message."""
    return 'Hei maailma!'

# Define class depend on the dependencies

class HelloWorld:
    """Implements HelloWorld using DI."""
    def __init__(self, message, output=PrintOutput):
        """Constructor."""
        self._message = message
        self._output = output

    def run(self):
        """Run HelloWorld."""
        self._output(self._message())

hw = HelloWorld(EnglishLanguage)
hw.run() # prints "Hello World!"

hw = HelloWorld(FinnishLanguage)
hw.run() # prints "Hei maailma!"
{% endhighlight %}

I think that the main reason people do not explore the use of the policy-based design in Python is due to this perceived equivalence with these runtime patterns. However, I would like to argue that policy-based design is a more general idiom that can express Strategy or Dependency Injection pattern as particular cases.

Now, using the policy-based design I can change both the behavior and also the *interface* of the **HelloWorld** class! Take for the first example and define **SaveOutput** policy class:

{% highlight python %}
# Example of policy-based design

...

class SaveOutput:
    """Implement save output policy."""
    def set_filename(self, filename):
        self.filename = filename
    def _output(self, message):
        with open(self.filename, 'w') as file:
            file.write(message)

...

HelloWorldEnglish = HelloWorld(
    Language=EnglishLanguage,
    Output=SaveOutput
)
hw = HelloWorldEnglish()
hw.set_filename('output.txt')
hw.run() # save "Hello World!" in output.txt
{% endhighlight %}
**Note**: find full example in my [github](https://github.com/baites/examples/blob/master/idioms/python/PolicyBasedDesignEx2.py).

In the example, the nature of the class because its interface is not the same. This is because **HelloWorldEnglish** has now a new member function *set_filename* inherited from **SaveOutput**. For this particular case, it might be possible to write a program that does the same using dependency injection and functors. However, the main issue is not about behavior, but rather what you need to express is a new class:

***Policy-based design allows us to create new classes (not only new functionalities) using as building block other predefine classes known as policies.***

## Elements of policy-based designed

### Multiple inheritance

Multiple inheritance is a feature in both C++ and Python, so no need to say more.

### Postpone inheritance

Policy-based design requires postponing the definition of the inheritance relationship between policy and host classes until coding time. You can accomplish this in C++ using templates.

{% highlight C++ %}
template<typename Policy1, typename Policy2, ...>
class HostClass: public Policy1, public Policy2, ... {
    /// Implements class affected by the policies."""
    ...
};
{% endhighlight %}

In Python, the same can be done using a factory method, as shown below.

{% highlight python %}
def HostClass(Policy1, Policy2=Default2, ...):
    class _(Policy1, Policy2, ...):
        """Implements class affected by the policies."""
        ...
    return _
{% endhighlight %}

The function **HostClass** is a factory of the "*class _*". I am using the class name *"_"* to signal that the name of the class inside of the factory is irrelevant. I define the structure of the host class inside of the factory. However, only when calling the factory function, the host class inherits from the policy classes.

### Class instantiation

The host class is instantiated when inherits from policy classes. This instantiation is done in C++ directly when coding or by using **typedef**.

{% highlight C++ %}
typedef HostClass<Policy1Class, Policy2Class, ...> NewClass;
{% endhighlight %}

In Python, I do the class instantiation by calling the factory function and passing the policy classes as arguments.

{% highlight python %}
NewClass = HostClass(Policy1Class, Policy2Class, ...)
{% endhighlight %}

### A policy can be an instantiated host class

An instantiated host class can also be a policy class. As a result, it is possible to create new policies by the composition of multiple successions host and policy classes, as shown below.

{% highlight python %}
class InputMessage:
    """Implement a message."""
    def run(self):
        return 'hello world'

def AddPrefix(Input):
    """Implement the concatenation of a prefix."""
    class _(Input):
        def set_prefix(self, prefix):
            self._prefix = prefix
        def run(self):
            return self._prefix + super().run()
    return _

def AddSuffix(Input):
    """Implement the concatenation of a suffix."""
    class _(Input):
        def set_suffix(self, suffix):
            self._suffix = suffix
        def run(self):
            return super().run() + self._suffix
    return _

def PrintOutput(Input):
    """Print message as output."""
    class _(Input):
        def run(self):
            print(super().run())
    return _

PrefixMessage = AddPrefix(InputMessage)
PrintPrefixSuffixMessage = PrintOutput(
    AddSuffix(AddPrefix(InputMessage))
)
message = PrintPrefixSuffixMessage()
message.set_prefix('Victor says ')
message.set_suffix(' and goodbye!')
message.run()
# Prints: Victor says hello world and goodbye
{% endhighlight %}
**Note**: find full example in my [github](https://github.com/baites/examples/blob/master/idioms/python/PolicyBasedDesignEx3.py).

## An example in a more realistic application

One example I can show when I am applying policy-based design is the following example of my implementation of an [interval tree](https://github.com/baites/pyds/blob/master/examples/avl_interval_tree.py). An interval tree is a specialized binary tree that supports operation in a dynamic set of closed intervals[^7]. In particular, this tree needs an extra function in the interface that I called *interval(...)*. This function takes as input an interval and returns a node in the tree with an overlapping interval or none otherwise.

In principle, any self-balance tree can be used to build this class, resulting in the following options:

* define an interval tree using one type of tree implementation, or
* define several interval trees as a child of all and each available tree implementation, or
* set interval tree-like class that get the tree implementation by object composition, or
* **define interval tree as a host class and inherence the tree implementations as a policy!**

I opted to use the latter approach because it clearly expresses that the interval tree is a tree (because of inherence the full tree interface from the policy). The host class implement the small addition to the tree interface is needed to query for overlapping intervals:

{% highlight python %}
# Define the tree type
Tree = IntervalTree(
    treetype=AVLBinarySearchTree
)
# Define actual tree instance
tree = Tree()
{% endhighlight %}
**Note**: find full example in my [pyds/avl_internal_tree](https://github.com/baites/pyds/blob/master/examples/avl_interval_tree.py).

If you suspect that interval values are inserted somewhat randomly, then you might want to avoid the use of balanced tree altogether!

{% highlight python %}
# Define the tree type
Tree = IntervalTree(
    treetype=SimpleBinarySearchTree
)
# Define actual tree instance
tree = Tree()
{% endhighlight %}
**Note**: find full example in my [pyds/simple_internal_tree](https://github.com/baites/pyds/blob/master/examples/simple_interval_tree.py).

## Final remarks

I hope I was able to convince you that it is possible to have a policy-based design in Python. However, likely, this approach is not as attractive as it is in C++ due to the fact Python is an interpreted language, and everything is at runtime. There is also a certain amount of controversy in the C++ community about this approach (do not take my word for it, just google it).

Therefore, remember to think twice if you need this approach in Python because as always ***with great power comes great responsibility***![^8]

## References

[^1]: [Wikipedia: Modern C++ Design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design#Policy-based_design).

[^2]: [Modern C++ Design: Generic Programming and Design Patterns Applied](https://www.amazon.com/Modern-Design-Generic-Programming-Patterns/dp/0201704315)

[^3]: [Wikipedia: Strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern)

[^4]: [Policy based design in Python](https://stackoverflow.com/questions/26533073/policy-based-design-in-python)

[^5]: Example in C++ example in [Wikipedia: Modern C++ Design, Policy-based design](https://en.wikipedia.org/wiki/Modern_C%2B%2B_Design#Policy-based_design). In the Python example, I am using the convention that one underscore implies a protected object variable. I am also doing the example in Finnish instead of German just for fun!

[^6]: [See Python Dependency Injection by Alex Martelli](http://www.aleax.it/yt_pydi.pdf).

[^7]: Interval trees in Chapter 14, page 348 of [Introduction to Algorithms, 3rd edition](https://www.amazon.com/Introduction-Algorithms-3rd-MIT-Press/dp/0262033844).

[^8]: [Wikipedia: With great power comes great responsibility](https://en.wikipedia.org/wiki/With_great_power_comes_great_responsibility)
