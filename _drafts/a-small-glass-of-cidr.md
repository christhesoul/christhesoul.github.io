---
layout: default
title: A small glass of CIDR
---

*Note: when I talk about IP addresses in this article, I am referring specifically to IPv4 addresses. I am aware that IPv6 addresses exist.*

:apple:

Most folks who've tinkered with internet things to any degree will have come across IP addresses. They look like this:

```
192.168.0.1
```

And like most kinds of address, it identifies where something is in relation to something bigger – in this case a device connected to a computer network.

Dive a little bit deeper and you might start to see ones that look like this:

```
192.168.1.15/24
```

So what's with `/24` at the end? What does *that* mean?

### A quick refresher

IP addresses look like `192.168.0.1` for the benefit of humans. If you're feeling fancy you can call it *dot-decimal notation*. Each one of the four groups can be a number from 0 to 255.

So each group has 256 options.

You can get two options from one *bit*. That's a 1 or a 0.

And so eight bits gives you 2 x 2 x 2 x 2 x 2 x 2 x 2 x 2 options. (More succinctly written as 2<sup>8</sup> if you're able to superscript, or 2^8 if you're limited to text.) And 2^8 = 256.

So if each group has 256 options, and there are four groups, then each IP address has 256 x 256 x 256 x 256 options. Which is 4,294,967,296.

Another way to look at if there are four groups of eight bits, then there are 32 bits in total. And 2^32 is also 4,294,967,296.

So to machines, IP addresses are simply 32-bit numbers that look like `11000000101010000000000000000001`.

And there are nearly 4.3 billion of 'em.

### Buying in bulk

So let's pretend you're a big organisation and you need a network with some IP addresses.

You go to the networking shop and they do three kinds of networks:

- **Pocket-sized Network** 256 addresses per network.
- **Classic Regular Network** 65,536 addresses per network.
- **Big Bertha Networks** 16,777,216 addresses per network.

You need 2,000 addresses in your network, so you have no choice to but to plump for a network with 65,536 addresses.

You get your network up and running, and forget about the 63k IP addresses that are unused.

Now, if you're very mathematically astute, you may have noticed a pattern in those address numbers:

<table>
  <tr>
    <td>256</td>
    <td>= 256^1</td>
  </tr>
  <tr>
    <td>65,536</td>
    <td>= 256^2</td>
  </tr>
  <tr>
    <td>16,777,216</td>
    <td>= 256^3</td>
  </tr>
</table>

This is no coincidence.

The big network – called a Class A network – allocates you the first group of the IP address, and leaves you to configure the next three. Apple purchased Class A network 17. Which means they own every IP address from `17.0.0.0` to `17.255.255.255`.

The regular network - called a Class B network - allocates you the first two groups of the IP address, and leaves you to configure the last two. Thus you might acquire every address from `173.191.000.000` to `173.191.255.255`.

The small network - called a Class C network – leaves you the final group of the IP address for your networking. This means something like `201.14.154.0` to `201.14.154.255` are yours to use as you wish.
