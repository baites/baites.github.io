---
layout: post
title: Are closures trivial?
date: 2017-12-11 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms
---

This is the forth post of a series dedicated to closures. You can find the other posts link in chronological order below.

* [Getting some closures]({% post_url 2017-11-20-getting-some-closures %})
* [Variable lifetime and closures]({% post_url 2017-11-27-variable-lifetime-and-closures %})
* [Made up patterns with closures]({% post_url 2017-12-04-made-up-patterns-with-closures %})

In my initial post I said that I found closures *a bit trivial* for high level language. However, I ended up writing *four posts* about them. This last post is to explain what I meant with this statement to avoid looking like as a *self-contradicting arrogant*.

> **Proposition**: closures are an avoidable (a necessary condition) when using **function objects**. By function objects, I mean the ability of passing, creating, and returning functions from one function scope to another. For example, languages when function are first-class objects, or they support lambda or anonymous functions.

Imaging in javascript passing callback functions without a closure. Due to the asynchronous nature of most of the applications in where javascript performs well, this could mean that callback's environment are inconsistent or undefined at the time it is called. The same apply when passing and returning functions in general, in where most scenarios, their execution are delegated to other scopes quite different to those in where functions are created. Closure seems to be the only way to have a consistent behavior with object functions.

One way to support this point, it is to look at language without closures until recent, that is **C++**. Anonymous functions were introduced in C++11 standard, and necessarily with them, it came the possibility of capture variables in to closures[^1]. A minimal working example is shown below, in where an anonymous function is returned after capturing *context* variable.

{% highlight cpp %}
#include <iostream>

using namespace std;

auto CreateClosure(const auto & context) {
    return [context]() { return context; };
}

int main(int argc, const char* argv[]) {
    // Creating closure in with "a unmutable" object
    // where context is captured by copy or value
    auto closure = CreateClosure("A");
    cout << "context in closureA: " << closure() << endl;
    return 0;
}
{% endhighlight %}

Now, one big difference relative to javascript and python cases, it is the fact that in C++ you need to *explicitly* specify if capturing variable by copy/value or by reference. For example, in the code above, *context* is captured by copy that is the default option. This feature is somewhat an avoidable in case of C++ in where object types are much lower level construct plus the fact C++ is not garbage collected. Therefore, it is important to control the mechanism to capture variables, to be sure which part of the code is responsible to free resources consume by capture variables.

Please follow the links for working C++ examples in where I test creating anonymous functions in where variable is capture [by copy](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByCopy.C) and [by reference](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByReference.C).

A previous post I discussed how variables can be shared between to closures. I also explain the *apparent lifetime extension* for captured variables[^2]. An equivalent example in C++ would as shown next [^3].

{% highlight cpp %}
#include <functional>

template<typename T>
tuple<function<T()>, function<void(T)>> CreateMethods(const T & value)
{
    T context = value;
    return {
        [&context]() { return context; },
        [&context](T value) { context = value; }
    };
}

int main(int argc, const char* argv[])
{
    auto [getContext, setContext] = CreateMethods("A")
    return 0;
}
{% endhighlight %}

The problem with this code is that in C++ its behavior is undefined. This is because *context* is captured by reference, and in C++ *context* is destroyed as soon as *CreateMethods(...)* returns, resulting in a closure with a dangling reference. This is commonly summarized by saying in C++ **closure do no extend variables lifetime**[^4]. You can pass the variable by copy, but in that case, those changes done using *setContext(...)* only affects its local copy of *context*, and it is not possible to retrieve a copy of its value by calling *getContext()*. In short, capturing by value does not allow sharing a reference to the value of *context* between closures!

I wrote two versions of closure with dangling references  [BrokenSharedContextClosures1.C](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/BrokenSharedContextClosures1.C) and [BrokenSharedContextClosures2.C](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/BrokenSharedContextClosures2.C). These programs crash very differently based on my tests, even though they are essentially the same. I follow what is actually happen to passed object by using a **LifetimeProbe** object like the one introduced for python examples in this previous post[^2].

The fact that C++ do not extend the lifetime of the variables captured by a closure is not a limitation of the language. It is directly related to the fact C++ does not have a garbage collector. This does not mean that we cannot almost trivially emulate one in C++ using for example smart pointers. Take a look at the code below in were context is a *shared pointer* to a new value.

{% highlight cpp %}
#include <functional>
#include <memory>

template<typename T>
tuple<function<T()>, function<void(T)>> CreateMethods(const T & value)
{
    shared_ptr<T> context(new T(value));
    return {
        [context]() { return (*context); },
        [context](const T & value) { (*context) = value; }
    };
}

int main(int argc, const char* argv[])
{
    auto [getContext, setContext] = CreateMethods("A")
    return 0;
}
{% endhighlight %}

In this example, *context* is capture by copy by both methods: *setContext*, *getContext*. The "values" of *context* are in reality references to an object in memory. This means that both methods have different copy of a shared pointer, however both pointers point to the same object in memory. When closures are destroyed at the end of the program, the last share pointer will destroy the object value in memory. [Here there is an fully working example](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/SharedContextClosures.C) of closures having references to same value using smart pointer. We use the *LifetimeProbe* object to follow how objects are created and destroyed.

So, are closures trivial? Of course not. However, it is important recognize they are an unavoidable result of support function objects!

[^1]: [Anonymous function since C++11.](https://en.wikipedia.org/wiki/Anonymous_function#C.2B.2B_.28since_C.2B.2B11.29)

[^2]: [Variable lifetime and closures]({% post_url 2017-11-27-variable-lifetime-and-closures %})

[^3]: This code uses several new features from C++11 and also up coming C++17 such as **decomposition declaration**. It seems that the syntax is so new that is confusing the code highlighting. Anyways, I compiled this code using g++ version 7.2.0 with the option *-std=c++1z*.

[^4]: [Closures: function objects in C++]( https://en.wikipedia.org/wiki/Closure_(computer_programming)#Function_objects_.28C.2B.2B.29)