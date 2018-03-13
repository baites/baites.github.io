---
layout: post
title: "Timeouts in python and why you should use python 3"
date: 2018-05-07 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science patterns
---

I started to prefer python 3 over python 2 recently and you should that too. First python 2.7 end of life date is in 2020 and there will not be a python 2.8[^1]. Second, python 3 syntax improvements and new API are so much nicer and practical, that so far it has being worth the effort of learning python 3. One example comes to my mind is when implementing timeout when making a system call or when calling a function within python interpreter.

Let's start with making a system call. An example of how to implement a system call protected by a timeout in python 2 can be found below

{% highlight python %}
import exceptions
import subprocess
import sys
import time

class TimeoutError(Exception):
    pass

def call(command, timeout=5, polltime=0.1):
    proc = None
    stdout = ''
    stderr = ''
    try:
        proc = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            close_fds=True
        )
        deadline = time.time() + timeout
        while time.time() < deadline and proc.poll() == None:
            time.sleep(polltime)
        if proc.poll() == None:
            proc.kill()
            raise TimeoutError('Command timeout')
        else:
            if proc.returncode:
                 raise subprocess.CalledProcessError(proc.returncode, command)
            stdout, stderr = proc.communicate()
    except:
        if proc.poll() == None:
            proc.kill();
        raise
    return stdout, stderr

stdout, stderr = call('echo works!')
print stdout, stderr
{% endhighlight %}

The implementation of this example plus some more comments about its implementation can be found in this code at my exercise [repo](https://github.com/baites/examples/blob/master/patterns/python/timeout/py2_system_call_timeout.py).

The equivalent example in python 3 is much simpler and it is shown below.

{% highlight python %}
from subprocess import PIPE, run

proc = run('echo works', shell=True, timeout=5, stdout=PIPE, stderr=PIPE)
print (proc.stdout.decode('utf-8'), proc.stderr.decode('utf-8'))
{% endhighlight %}

As you can see, the previous example the timeout is now a native functionality of the new API. Now, you might think this is not such a big deal. However, inappropriate timeout implementation opens the possibility of leaving dangling subprocesses in some edge case when exceptions are raised. If your program run for a long time, this could leak processes used when for executing each command, eventually depleting host resources.

Another non trivial implementation is adding a timeout for function called within the python interpreter. This created several discussions in different forums[^2] and it was also the inspiration for small timeout library[^3]. However, using new python 3 *concurrent.futures* API, it is possible to create a simple function timeout. This is also because the timeout functionality is native functionality of the API.

For example, if you would like to make a timeout decorator, you can write something like it is shown below.

{% highlight python %}
from concurrent.futures import ThreadPoolExecutor
from functools import wraps
import time

def ftimeout(timeout):
    """Implement function timeout decorator."""
    def decorator(callback):
        @wraps(callback)
        def wrapper(*args, **kargs):
            with ThreadPoolExecutor(max_workers=1) as executor:
                future = executor.submit(callback, *args, **kargs)
                return future.result(timeout=timeout)
        return wrapper
    return decorator
{% endhighlight %}

You can now add a timeout by simply decorating the function of interest:

{% highlight python %}
@ftimeout(timeout=2)
def sleep(secs):
    time.sleep(secs)
# it will timeout before return
sleep(secs=4)
{% endhighlight %}

for fully functional example can be found in my [example repo](https://github.com/baites/examples/blob/master/patterns/python/timeout/py3_function_call_timeout.py).

It is also possible to decorate functions with timeouts that collect the amount of waiting time from the class itself. Take a look at this decorator below.

{% highlight python %}
from concurrent.futures import ThreadPoolExecutor
from functools import wraps
import time

def mtimeout(attribute):
    """Implement function member timeout decorator."""
    def decorator(callback):
        @wraps(callback)
        def wrapper(self, *args, **kargs):
            timeout = getattr(self, attribute)
            with ThreadPoolExecutor(max_workers=1) as executor:
                future = executor.submit(callback, self, *args, **kargs)
                return future.result(timeout=timeout)
        return wrapper
    return decorator
{% endhighlight %}

You can use this in the following way:

{% highlight python %}
class ObjectType:
    def __init__(self, timeout):
        self._timeout = timeout
    @mtimeout(attribute='_timeout')
    def sleep(self, secs):
        time.sleep(secs)

o = ObjectType(timeout=2)
# it will timeout before return
o.sleep(4)
{% endhighlight %}

for fully functional example can be found in my [example repo](https://github.com/baites/examples/blob/master/patterns/python/timeout/py3_member_call_timeout.py).

So there you have it, a few examples of improved python 3 API that I found particular useful. This is because in the era of distributed applications and micro services, it is fundamental to protect your code from undefined behavior using timeouts.

#### References

[^1]: [PEP-0373: Python 2.7 Release Schedule](https://www.python.org/dev/peps/pep-0373/#update)
[^2]: [Using a Python timeout decorator for uploading to S3](https://www.saltycrane.com/blog/2010/04/using-python-timeout-decorator-uploading-s3/). [Timeout function if it takes too long to finish](https://stackoverflow.com/questions/2281850/timeout-function-if-it-takes-too-long-to-finish).
[^3]: [timeout-decorator](https://pypi.python.org/pypi/timeout-decorator)
