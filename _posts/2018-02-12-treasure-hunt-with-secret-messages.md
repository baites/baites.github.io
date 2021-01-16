---
layout: post
title: Treasure hunt with secret messages
date: 2018-02-12 08:00:00 -0400
author: Victor E. Bazterra
categories: cryptography recreational-series
---

| This blog is part of a series dedicated to recreational topics for my daughter. [In the Series page you can find all the posts of the series]({{ 'series#recreational-series' | relative_url }} ). |

**My daughter in her late 5-year old**: *daddy, you know there is a language that can be used to write secrets.*

**Me**: *Say what now?*

**My daughter** (impatient face, signaling me to start better catching up): *That, there is a language that can be used to write secrets*.

**Me**: Well you can write a message in another language, and if people do not know it, then its message is hidden to them.

**My daughter** (frustrated face): *No that. There is a language that can be used to write secrets and to use a key...*

**Me** (how is it possible, five years old!?): *Where did you hear that?*

**My daughter** (ignoring me): *...and you can use a key to learn the secret message.*

**Me** (proud beyond words): *That is call cryptography! Where did you learn about that?*

**My daughter** (is-it-obvious face): *I do not know.*

**Me**: Do you want to learn how to do that?

**My daughter** (opening her eyes and putting her finally-daddy-you-are-becoming-useful face): *yes!*

**Me**: *But be aware, you have to read and write and you just barely learned how to do it...*

**My daughter** (interrupting with her move-on face): *ok!*

**Me**: *And we need to use math, you need to combine reading, writing, and math as one thing...*

**My daughter** (excited face): *Oh boy, oh boy, ...*

**Me**: *Are you sure you want to do it?*

**My daughter**: **YES!!!**

So, this is how we started our treasure hunt with secret messages. I encrypted the messages with algorithm simple enough to be decrypted by my 5-6-year-old daughter. Once decoded, each message points to the location of the next encrypted clue. The game ends when one of the clues leads to the location of the treasure.

We first defined an alphabet of 27 characters (traditional 26 English alphabets plus space) and pair each character with a number or index, see picture below.

![Indexed alphabet]({{ "/assets/images/treasure-hunt-alphabet.jpg" | absolute_url }})

We then play the game with two level of difficulties when decrypting messages.

At the most manageable level, the secret message contains a ciphertext and numerical key. Each number of the key tells you the number of backward rotation steps you need to do to recover the plaintext. For example, if the key was **3** and the corresponding cyphertext letter is **E** then plaintext character is **B**. I restricted the key numbers between 0 to 4 to make it easy to do the rotation manually. For all the versions of our game, the key and ciphertext lengths are the same.

For the next level of difficulty, we replaced the numbers in the key for their corresponding letter of the alphabet. Therefore, the new secret message contains both key and ciphertext written with the same alphabet. The decryption then requires two steps: one step to convert the key into a numerical key, and then use the numerical key to backward rotate each ciphertext character. In the picture below, you can find three decryption examples done by my daughter. Each paper represents one of the clues used in one treasure hunt.

![Decryption example]({{ "/assets/images/treasure-hunt-decrypt.jpg" | absolute_url }})

What follows is a description of each piece of paper shown in the picture. The first line in red is the alphanumeric key written by me. The second line in black is the numeric key decoded by my daughter. The third line also in black is the ciphertext provided by me. Finally, the last line in red is the plaintext decrypted by my daughter.

An optional degree of difficulty can be added for multilingual families if their share languages have the same or similar alphabet as in English. You can write plaintext in different languages without specifying it in advance!

The game became so popular with my daughter that I got tired of creating the encrypted clues by hand. As result, I wrote [encrypting](https://github.com/baites/examples/blob/master/daughter/python/encrypt.py) and [decrypting](https://github.com/baites/examples/blob/master/daughter/python/decrypt.py) programs in python. For example, if you want to encrypt the phrase "big bed" (short for master bedroom) you need to do the following:

{% highlight bash %}
>./encrypt.py big bed
Key: ECCDECD
Ciphertext: FKICFGG
{% endhighlight %}

You can verify the encryption by decrypting the message as follow:

{% highlight bash %}
>./decrypt.py ECCDECD FKICFGG
Plaintext: BIG BED
{% endhighlight %}

What I like about this game is that my daughter learned that language and math are or can be intertwined. That both are just specific languages to represent different types of meanings, and that in several contexts, the only way to convey the right message is by using a combination of both.

So have fun with kids by having treasure hunts with secret messages!
