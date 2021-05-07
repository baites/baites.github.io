---
layout: post
title: Why most common hashes uses prime modular arithmetic?
date: 2029-01-01 08:00:00 -0400
author: Victor E. Bazterra
categories: algorithms algebra
javascript:
  katex: true
---

* TOC
{:toc}

## Introduction

This is a follow up to my pervious post ([String hashing and palindromes]({% post_url 2020-03-23-string-hashing-and-palindromes %})).

I have little or no expertise about the details discussed in here, therefore a diclaimer inspire by MIT license wording:

{% include statement/disclaimer %}
THE "KNOWLEDGE" IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE "KNOWLEDGE" OR THE USE OR OTHER DEALINGS OF THE "KNOWLEDGE".
{% include statement/end %}

## References

[^1]: [Why should hash functions use a prime number modulus?](https://stackoverflow.com/questions/1145217/why-should-hash-functions-use-a-prime-number-modulus)
[^2]: [Why is it best to use a prime number as a mod in a hashing function?](https://cs.stackexchange.com/questions/11029/why-is-it-best-to-use-a-prime-number-as-a-mod-in-a-hashing-function).
[^3]: [Does making array size a prime number help in hash table implementation? Why?](https://www.quora.com/Does-making-array-size-a-prime-number-help-in-hash-table-implementation-Why).