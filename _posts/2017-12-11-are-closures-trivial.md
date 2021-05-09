---
layout: post
title: Are closures trivial?
date: 2017-12-11 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science idioms closure-series
---

| This blog is part of a series dedicated to function closures. [In the Series page you can find the other posts of the series]({{ 'series#closure-series' | relative_url }} ). |

In the initial post of the series, I said that I found closures *a bit trivial* for a high-level language. However, I ended up writing *four blogs* about them. This last post is to explain what I meant by this statement to avoid looking like as a *self-contradicting arrogant*.

{% include statement/proposition %}
closures are unavailable (a necessary condition) when using **function objects**. By function objects I mean the ability of passing, creating, and returning functions from one function scope to another. For example, this is the case for languages in where function are first-class objects, or they support the use of lambda or anonymous functions.
{% include statement/end %}

Imagine in javascript passing callback functions without a closure. Due to the asynchronous nature of most of the applications in where javascript performs well, this could mean that callback's environment is inconsistent or undefined at the time it is called. The same applies when passing and returning functions in general, where for most scenarios, their execution is delegated to other scopes entirely different to those in where functions were created. It seems as the only way to have a consistent behavior with object functions is by having closures.

One way to support this point, it is to look at language without closures until recent, that is **C++**. With the introduction of anonymous functions in C++11 standard came unavoidably the possibility of capture variables into closures[^1]. A minimal working example is shown below, where I return an anonymous function after capturing *context* variable.

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

Now, one big difference, relative to javascript and python cases, is the fact that in C++ you must specify if variable needs to be captured by copy/value or by reference. For example, in the code above, *context* variable is captured by copy that is the default option. This feature is somewhat unavoidable in case of C++ in where object types are low-level construct besides that C++ is not garbage collected. Therefore, it is essential to control the mechanism to capture variables, to explicitly define the part of the code responsible for freeing resources consume by capture variables.

Please follow the links for working C++ examples in where I test creating anonymous functions by capturing a variable [by copy](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByCopy.C) and [by reference](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByReference.C).

A previous post I discussed how variables could be shared between closures. I also explain the *apparent lifetime extension* for captured variables[^2]. An equivalent example in C++ would be as shown next example[^3].

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

The problem with this code is that its behavior is undefined. This is because *context* is captured by reference, and *context* value is destroyed as soon as *CreateMethods(...)* returns, resulting in a closure with a dangling reference. This is commonly summarized by saying in C++ **closure do no extend variables lifetime**[^4]. You can pass the variable by copy, but in that case, those changes are done using *setContext(...)* only affects its local copy of *context*, and it is not possible to retrieve a copy of its value by calling *getContext()*. In short, capturing by value does not allow sharing a reference to the value of *context* between closures!

I wrote two versions of closures with dangling references  [BrokenSharedContextClosures1.C](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/BrokenSharedContextClosures1.C) and [BrokenSharedContextClosures2.C](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/BrokenSharedContextClosures2.C). These programs crash very differently based on my tests, even though they are mostly the same. I follow what is happening to input object by using a **LifetimeProbe** object like the one introduced for python examples in the previous post[^2].

The fact that C++ does not extend the lifetime of the variables captured by closure is not a limitation of the language but related to the fact C++ does not have a garbage collector. This does not mean that we cannot almost trivially emulate one using, for example, smart pointers. Take a look at the code below in where context is a *shared pointer* to a new value.

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

In this example, *context* is capture by copy by both methods: *setContext*, *getContext*. The "values" of *context* is in reality references to an object in memory. This means that both methods have a different copy of a shared pointer in where both point to the same object in memory. When closures are destroyed at the end of the program, the last shared pointer will destroy the object value in memory. [Here there is a fully working example](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/SharedContextClosures.C) of closures having references to same value using a smart pointer. We use the *LifetimeProbe* object to follow how objects are created and destroyed.

So, are closures trivial? Of course not. However, it is crucial recognize they are an unavoidable result when supporting function objects!

# References

[^1]: [Anonymous function since C++11.](https://en.wikipedia.org/wiki/Anonymous_function#C.2B.2B_.28since_C.2B.2B11.29)

[^2]: [Variable lifetime and closures]({% post_url 2017-11-27-variable-lifetime-and-closures %})

[^3]: This code uses several new features from C++11 and also upcoming C++17 such as **decomposition declaration**. It seems that the syntax is so new that is confusing the code highlighting. Anyways, I compiled this code using g++ version 7.2.0 with the option *-std=c++1z*.

[^4]: [Closures: function objects in C++]( https://en.wikipedia.org/wiki/Closure_(computer_programming)#Function_objects_.28C.2B.2B.29)
