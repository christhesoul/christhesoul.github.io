---
title: Chris Waters
headline: Make the change easy. Then make the easy change.
bg-color: yellow
---

(That's a Kent Beck quote. It continues to resonate.)

Web-based software products (my career and continued fascination) change all the time.

Partly because they can, and mostly because life happens to the businesses that build them: new customers, technology, regulations, and trends – all bringing their own picnic of demands, quirks, and problems.

But before you make changes, you've got to understand how the code is executing right now.

# Bad code makes you feel like you need to understand everything to understand anything.

(That's a Sandi Metz quote. She's the finest teacher I've ever had. Thanks Youtube.)

Programmers spend more time reading code than writing code. So it's critical that the code we write is easy to read.

Which is easier said than done.

People rarely write code that is deliberately _hard_ to read. It just happens with time and tide – a bad variable name here, a confusing negated boolean check there, and the classic _quick fix_ that becomes a permanent fix to make a convoluted test pass that a developer who no longer works for you wrote four years ago.

# Any fool can write code that a computer can understand. Good programmers write code that humans can understand.

(That's a Martin Fowler quote. He's not short of good ones.)

And so we must write software well.

It turns out that writing software well isn't too dissimilar from writing _anything_ well.

Good writing is subjective but there are recurring themes:

### 1. Cut superfluous words

Brevity brings clarity. Use the right words in the right place. Without good choices, sentences meander; paragraphs bloat.

Software is no different: the same intention can be reached with more code than is necessary. Understand your libraries and the power within them.

### 2. Good writers are avid readers

"Writing is learned by imitation. If anyone asked me how I learned to write, I’d say I learned by reading the men and women who were doing the kind of writing I wanted to do and trying to figure out how they did it." William Zinsser in *On Writing Well*.

Read the docs. Scour the source code. Attend the talks. Seek out the books. Somebody, somewhere is most probably writing software in a way that just feels right – even if you can't express why, exactly. Follow your nose.

### 3. Never underestimate editing

The plot in a book is always obvious to the writer; every interweaving detail is coherent, each character's traits apparent. But the writer's best intentions do not always make it onto the page. And so an editor's work is crucial.

Having your code reviewed and edited serves an identical purpose: it can eliminate clumsy mistakes, highlight areas where meaning seems vague, and provide suggestions that make the code's purpose clearer.

# If you love writing code, you'll love it enough to write as little of it as possible.

(That one's from Jeff Atwood.)

Regardless of your code quality, making changes is easier when there are fewer changes to make. So write less code.

Let me be crystal clear: the act of reducing line lengths with abbreviated variable names or ternary operators is not the intended pursuit. Shorthand is easier for some to write. It is certainly not easier for the majority to read.

This is simply about doing less programming by making better decisions.

You can't make good decisions until you choose from a smorgasbord of solutions. And to assemble such a thing, you need to dive deep into understanding problems.

# A problem is a difference between things as desired and things as perceived

(That's from _Are Your Lights On?_ by Donald C. Gause and Gerald M. Weinberg.)

You might think users _perceive_ your app to be slow. And they _desire_ much faster response times from the server.

But what if your users perceive your app not to be slow, but _completely unresponsive_? All of a sudden, your problem is not about speed or performance – but simply about feedback and expectations.

(To paraphrase the wonderful Rory Sutherland: everybody seems intent on building billion dollar high-speed trains, but who'd complain about a slower one serving free champage?)

Relentlessly ask yourself _what is actually the problem_ and _whose problem is it_?
