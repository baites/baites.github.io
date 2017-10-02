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

In my initial post I said I found closures *a bit trivial* for high level language, however I ended up writing *four post* about them. This last post is to explain what I meant with this statement to avoid looking like as a *self-contradicting arrogant*.

> In summary, I think closures are an avoidable (a necessary condition) when using **function objects**. By function objects, I mean the ability of creating, passing, and returning functions from and to other function scopes. For example, languages when function are first-class objects, or they support lambda or anonymous functions.

Imaging in javascript passing callback functions without closure. Due to the asynchronous nature of the language and most of the applications in where it performs well, this could mean that callback's environment are inconsistent or undefined at the time they are called. The same apply when passing and returning functions in general, in most of this scenarios their execution are delegated to other scopes, quite different to those in where functions were created. Closure seems to be the only way to have object functions and a consistent behavior.

One way to support this point, it is to look at language without closures until recent, that is **C++**. Anonymous functions were added in C++11 standard, and necessarily with them, it came the possibility of capture variables in to closures[^1]. A minimal working example is shown below, in where we returned an anonymous function after capturing *context* variable.

{% highlight C++ %}
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

Now, one big difference relative to javascript and python cases, it is the fact that in C++ you need to *explicitly* specify if capturing variable by copy/value or by reference. For example, in the code above, *context* is captured by copy. I thinks this is somewhat an avoidable in case of C++, in where object types are much lower level construct plus the fact C++ is not garbage collected.

Please follow the links for working C++ examples in where I test creating anonymous functions in where variable is capture [by copy](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByCopy.C) and [by reference](https://github.com/baites/examples/blob/master/idioms/c%2B%2B/ClosureByReference.C).



[^1]: [Anonymous function since C++11.](https://en.wikipedia.org/wiki/Anonymous_function#C.2B.2B_.28since_C.2B.2B11.29)
