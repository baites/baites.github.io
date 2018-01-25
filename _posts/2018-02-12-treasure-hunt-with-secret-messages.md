---
layout: post
title: Treasure hunt with secret messages
date: 2018-02-12 08:00:00 -0400
author: Victor E. Bazterra
categories: cryptography recreational
---

**My daughter in her late 5-year old**: *daddy, you know there is a language that can be used to write secrets.*

**Me**: *Say what now?*

**My daughter** (impatient face, signaling me to better start catching up): *That, there is a language that can be used to write secrets*.

**Me**: Well you can write a message in another language and if people do not know it, then its message is hidden to them.

**My daughter** (frustrated face): *No that. There is a language that can be used to write secrets and using a key...*

**Me** (WTF, 5 year old!?): *Where did you hear that?*

**My daughter** (ignoring me): *...and you can use a key to learn the secret message.*

**Me** (proud beyond words): *That is call cryptography! Where did you learn about that?*

**My daughter** (is-it-obvious face): *I do not know.*

**Me**: Do you want to learn how to do it?

**My daughter** (opening her eyes and putting her finally-you-are-becoming-useful face): yes!

**Me**: But be aware, you have to read and write and you just barely learned how to do...

**My daughter** (interrupting with her move-on face): *ok!*

**Me**: And we need to use math, you need to combine reading, writeing, and math as one thing...

**My daughter** (excited face): *Oh boy, oh boy, ...*

**Me**: Are you sure you want to do it?

**My daughter**: **YES!!!**

So, we started a game of treasure hunt with secret messages. The secret messages were encrypted with algorithm simple enough to be decrypted by my 5-6 year old daughter. Each message once decrypted, point to the location of the next encrypted clue.

We started by defining a alphabet of 27 characters (traditional 26 English alphabet plus space) and putting a number to index each character.

![Indexed alphabet]({{ "/assets/images/treasure-hunt-alphabet.jpg" | absolute_url }})

We play the game by having has two level of difficulties for the decryption.

The easiest level, the secret message contain a ciphertext and numerical key. Each number of the key tells you the number of backward rotation steps you need to do to recover the plaintext. This means, that the key and ciphertext lengths are the same. For example, if the key was **3** and the corresponding cypertext letter is **E** then plaintext character is **B**. I restricted the key numbers between 0 to 4 to make it easy to do the rotation manually.

For the next level of difficulty, I replaced the numbers in the key for their corresponding letter of the alphabet. Therefore, the new secret message contain alphanumeric key plus a ciphertext. The decryption then require two steps: one step to convert the key in to a numerical key, and then use the numerical key to backward rotate each ciphertext character. Below you can find three decryption examples done by my daughter. Each paper represents one of the clues used in one treasure hunt.

![Decryption example]({{ "/assets/images/treasure-hunt-decrypt.jpg" | absolute_url }})

What follow is a description that applies for each piece of paper. The first line in red is the alphanumeric key written by me. The second line in black is the numeric key decoded by my daughter. The third line also in black is the ciphertext give by me. Finally the last line in red is the plaintext decrypted by my daughter.

An optional degree of difficulty can be added for multilingual families with same or similar alphabet as in English, in where the language of plaintext is not specified!

The game become so popular with my daughter I got tired of creating the encrypted clues by hand. Therefore, I wrote [encrypting](https://github.com/baites/examples/blob/master/daughter/python/encrypt.py) and [decrypting](https://github.com/baites/examples/blob/master/daughter/python/decrypt.py) programs in python. For example, if you want to encrypt the phrase "big bed" (short for master bedroom) you need to do the following:

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

What I like about this game is that my daughter learn language and math are somewhat intertwine. That both are just specialized languages to represent different type of meaning, and that in several contexts, the only way to convey the right message is by using a combination of both.

So have fun with kids by having happy treasure hunts!
