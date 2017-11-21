---
layout: post
title: Getting some closures
date: 2017-11-21 05:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms
---

I find the notion of closures fundamental and a bit trivial in high level languages with *first-class function*. So, I was surprised seeing the large number of forums in where they are discussed, and also how it is used in interview for a job that require coding in a high level language (in particular for javascript).

But before getting too much in the discussion, let me define first what are **closures**. The simplest definition I can think of goes something like this:

> A **closure** is the association between a function and some variables present in the scope when the function was defined. Effectively, a closure becomes a combination of the function and an environment made of the these **captured** variables[^1].

Closures are a computer language feature, so I will be using C++, javascript, and python to illustrate the main concepts in this and future posts. The minimal example of a closure is the following code

{% highlight python %}
def CreateClosure(context):
    def method():
        return context
    return method

closure = CreateClosure('A')

print('', closure())
#> context in closure: A
{% endhighlight %}

in where the closure is made of a *method* function and the *context* variable. This is because when the function returns *method* function, implicitly python is also returning capture variable *context*.

It is important to spell out that returning a reference or pointer to a function **does not create a closure**! For emphasis, I am writing the following example using C++ that did not support closures before C++11[^2].

{% highlight C++ %}
// Example of what is not a closure!
#include <iostream>
#include <sting>

using namespace std;

// Defining context and method in global namespace.
string context = "";
string Method()
{
    return context;
}
// Return a reference to Method.
string (*CreateMethodWithContext(string value))()
{
    context = value;
    return Method;
}
int main(int argc, const char* argv[])
{
    // Create a reference to method and set context
    string (*method)() = CreateMethodWithContext("A");
    cout << "context when calling method: " << method() << endl;
    return 0;
}
//> context when calling method: A
{% endhighlight %}

In this case there is not need to create a closure made of *method* and a *context* because both exist in the global name space, and therefore they are trivially accessible throughout the whole program. For this particular case, it is possible to write a version in  [C++](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/NoClosure.C), as well in high level languages like [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/NoClosure.js), and [python](https://github.com/baites/examples/blob/master/idioms/python/NoClosure.py).

One question that naturally arises is how the variables are captured, by copy/value or by reference[^3]. The answer for both javascript and python depends on the nature of the input *context*. If *context* is an immutable object, then the closure tend to behave as a *capture by copy/value*. This is because immutable objects cannot be changed, and therefore it looks like as the closure contains only the value of *context*. By other hand, if input *context* is a mutable object, then it is possible change *context* value using the initial reference pass to the *CreateClosure* function. The following code in [javascript](https://github.com/baites/examples/blob/master/idioms/javascript/SimpleClosure.js), and [python](https://github.com/baites/examples/blob/master/idioms/python/SimpleClosure.py) provide working examples of these two behaviors.

A follow up question is then: what about the life cycle of those variables capture in closures? The answer to that question will be the topic of my next post.

#### References

[^1]: [Closure (computer programming).](https://en.wikipedia.org/wiki/Closure_(computer_programming))

[^2]: Closures are supported starting with C++11 standard as part of new anonymous functions.

[^3]: One should be careful of using the notion of **copy/value** and **reference** related closely to C++ but not directly translatable for garbage collected high level languages such python or javascript. This is why I will be using expression such as *behaves like by copy or reference*.
