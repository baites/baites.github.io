---
layout: post
title: "My legacy code rises again: agentic coding and old projects"
date: 2026-06-18 08:00:00 -0400
author: Victor E. Bazterra
categories: computer-science agentic-coding
---

Over the years I have accumulated a small graveyard of side projects. Each of them started with genuine excitement, a clear idea, and a first burst of commits, and then slowly went quiet. It was rarely because I stopped caring. It was because keeping a personal project alive is expensive: dependencies drift, the tooling I set up two or three years ago no longer builds, and every time I came back I had to spend a weekend just remembering how my own code worked before I could change a single line.

Agentic coding has quietly changed that arithmetic for me. What used to be a tedious archaeology session, re-learning my own dead code and fighting the build, is now closer to a guided conversation. I can point an agent at a dormant repository, ask it to explain what is there, get the tests running again, and modernize the pieces that aged badly, all in a fraction of the time it used to take.

{% include statement/remark %}
The real barrier was never writing the code. It was the recurring cost of re-entry, and that is exactly the cost agentic coding drives down.
{% include statement/end %}

One of the projects I brought back this way is *pystash*, and this is the first time I am presenting it to the world. The idea behind it is simple and, honestly, a little selfish: I wanted a place to write code in order to learn coding, and to keep a clear, trustworthy reference for the basic algorithms and data structures I never want to have to look up twice.

{% include statement/project name="pystash" %}
A personal, dependency-free stash of clean, well-documented implementations of fundamental algorithms and data structures in Python, written to learn coding and to serve as a clear reference, useful for self-study, competitive programming, and technical interviews. Tested and linted, it is mirrored on [GitHub](https://github.com/coding-stash/pystash) and [GitLab](https://gitlab.com/coding-stash/pystash).
{% include statement/end %}

Because it deliberately avoids external libraries, every implementation is meant to be readable on its own and easy to copy and paste when you need it under pressure, whether that is a contest clock or an interview whiteboard. And because it is a real project rather than a gist folder, it comes with tests, linting, and continuous integration for validation.

What excites me most is not the one-time resurrection but what comes after. With an agent in the loop, keeping dependencies fresh, tests green, and CI passing stops being the chore that killed these projects in the first place. For the first time in a long while, I feel like my legacy projects can stay alive instead of becoming frozen snapshots of who I was when I wrote them, and *pystash* is only the first one I am bringing back.
