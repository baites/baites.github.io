---
layout: post
title: "Relearning C++ with cppstash and an agent's help"
date: 2026-07-14 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science agentic-coding
---

In my last post I wrote about how an agent helped me revive *pystash*, one of my dormant side projects, and keep it alive instead of letting it freeze. This is the sequel, and it has a twist: the project I want to talk about now is *pystash*'s older C++ sibling, *cppstash*, and this time the agent's role is smaller and more precise than you might expect.

*pystash* came first. It was the Python stash where I collected clean implementations of the algorithms and data structures I never wanted to look up twice. *cppstash* came later, and it was deliberate. I once wrote C++ nearly fluently, and over the years that fluency quietly eroded. On top of that, the language kept moving: a whole wave of features arrived from C++11 onward that I had simply never made mine. So I did the only thing that actually works for me, which is to sit down and re-implement the same algorithms by hand, in C++, line by line. The point was never the artifact. It was the practice, because that is how both a language and its newer idioms come back to you.

{% include statement/project name="cppstash" %}
A personal, dependency-free stash of clean, well-documented implementations of fundamental algorithms and data structures in C++, hand-written to relearn the language and to serve as a clear reference, useful for self-study, competitive programming, and technical interviews. Built with CMake and covered by unit tests, stress tests, static analysis, and coverage reporting, it is mirrored on [GitHub](https://github.com/coding-stash/cppstash) and [GitLab](https://gitlab.com/coding-stash/cppstash).
{% include statement/end %}

I wrote every line of *cppstash* myself, back then in C++17, build files and all. What aged was never the algorithms; a topological sort is a topological sort. It was the scaffolding around them. Years later the code no longer compiled, and C++ itself had moved on, from the C++17 I had reached for to a very different C++23. That decay, not the writing, is exactly the kind of thing that used to strand a project like this for good.

So I brought an agent in, but only for support. It got the old code compiling again and helped me modernize the idioms toward C++23, and that was the whole of its job. It did not write the algorithms for me, because writing them is the entire reason the project exists.

{% include statement/remark %}
The division of labor is the point: I write the algorithms by hand, and the agent maintains the ground they stand on.
{% include statement/end %}

*cppstash* is still behind its Python sibling and it will probably be forever. Right now it covers the core graph traversals, depth-first search, acyclic checks, connected components, reachability, and topological sort, but breadth-first search, strongly connected components, and the entire data-structure section that *pystash* already has, the heap, the binary search tree, the linked list.

That is what makes this feel sustainable rather than nostalgic. Keeping the scaffolding alive, the builds, the tooling, the idioms that quietly go stale, was always the cost that drained the time and the will out of a project like this. With most of that cost off my plate, I can spend what little time I have on the part that actually matters to me here: writing the missing pieces by hand, and reclaiming a bit more of the C++ I once knew.
