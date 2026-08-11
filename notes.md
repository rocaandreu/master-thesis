# State of the art 

## why linked lists are not really used):

The focus here is to find hardware-based management of dynamic memory.

 - One of the famous options would be linked lists, but these are not really used in NiC hardware except for buffer chaining. I.e. we need predictable latency, and a stock linked list can have a latency as high as the memory depth which is not acceptable. Buffer chaining is used when the data is wider than the memory, so we point to the next section of the packet. This is acceptable because we have a hard cap at pkt_size = MTU (1500 bytes). 

```
```
The canonical thing: descriptor rings (and why they replaced lists)

Most NICs (including smart NICs) use ring buffers instead of linked lists:

Fixed-size circular arrays of descriptors
Each descriptor points to a packet buffer
Managed by head/tail pointers in hardware

Why rings win:

No pointer chasing → predictable latency
Cache-friendly (contiguous memory)
Easy DMA

Classic references:

The Click Modular Router (not hardware, but influential in packet buffer design thinking)
PacketShader: a GPU-Accelerated Software Router (discusses batching vs pointer-heavy structures)

👉 Insight: hardware avoids linked lists on the fast path whenever possible
``

## Patent on how to design this shit
https://patents.google.com/patent/US7035988B1/en

## A paper on buffering strategies (2007, 11 citations)

https://scholarworks.utrgv.edu/cgi/viewcontent.cgi?article=1003&context=ece_fac

This paper seems to account only for allocation policies and algorithms rather than the implementation, but still can be useful. It is basically algorithms to decide how much space we allocate to every flow (i.e. application).

It seems there are algorithms whose goal is to calculate the threshold at which to start dropping data. I.e. the amount of memory allocated to each flow:

 - A: Completed Partitioned Algorithm (CP): Basically static allocation, every flow gets a fixed ammount of memory:
    - Works well if all flows are active
    - Can't adapt to varying traffic
    - We split the whole buffer space (M) into N fragments of equal size k1, k2..., ki

 - B: Completed Shared Algorithm (CS): Dynamic allocation:
    - A packet will be received as long as there is space in the whole buffer (M) to allocate it
    - A single application can eat up the whole buffer

 - C: Dynamic Algorithm (DA):
    - The threshold value of every flow is a function of the total available space, essentially a threshold T that varies over time like so:
    - T(t) = A x (M - Q(t)) --> A is a constant, M is total buffer space, and Q is used buffer space --> Vamos q es una puta recta
    - Does not consider that different applications have different packet sizes

 - D: Dynamic Algorithm with Dynamic Threshold (DADT):
    - Same as before, but A is different for every flow, this way we can tune the allocation priority and fairness for every application
        - Smells like something we can configure over AXI and is close to the intuition we had with William

### The algorithm proposed by the paper: History-Based Dynamic Algorithm

An evolution of DADT that takes into account application state (active or inactive):
  - TODO: Dive into the algorithm a bit, it's not that hard but I just haven't read it yet.

## A paper designing packet buffers for router linecards

https://yuba.stanford.edu/~nickm/papers/TR02-HPNG-031001.pdf

- Tells us to use a SRAM --> DRAM (or hbm in our case) hierarchy
- Guarantees SRAM-like behaviour, meaning no errors allowed (unsure about what this means)
- I'm not sure policy is covered here, we can complement it with the algorithm from the last paper

### Random ideas about buffering

- Maybe we can use a 512 bit-per-node linked list to fragment memory and waste less space in memory with smaller packets.
- We can cache the first packets of every flow to have time to feed them to the encoder while we access HBM.
- Problem: HBM uses 


## TODO Papers
A Specialized Memory Hierarchy for Stream Aggregation: https://ieeexplore.ieee.org/abstract/document/9556485/references#references
