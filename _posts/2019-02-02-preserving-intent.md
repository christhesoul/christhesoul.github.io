---
layout: default
title: Preserving Intent
---
:camping:

**Warning: contains real code**

I have the pleasure of working with lots of great junior developers through
our partnership with [Netguru](https://www.netguru.com/).

I enjoy the process of code reviews, because they provide the ideal time to
pass on some of the things I've learned; where abstract concepts can be applied
to concrete code.

What follows is the story of a really quick back-and-forth that I believe
improved the readability of one single method in our Rails monolith.

**The task**

The task involved producing a daily business report for all our wonderful
[Inn Style](https://www.innstyle.co.uk) customers, and in particular displaying
the Average Daily Rate (ADR) for a particular hotel or B&B.

As hotel rates fluctuate depending on demand and other factors, revenue
managers are keen to know what their ADR is (or was) for any given day.

The formula for calculating the Average Daily Rate is simple:

```
total value of the bookings for that day / number of bookings on that day
```

Thus if we have three bookings totalling £270, our ADR is £90.

We can express this in Ruby as:

```ruby
def average_daily_rate
  booking_value / rooms_booked
end
```

So we're golden, right?

`booking_value` returns a [Ruby Money](https://github.com/RubyMoney/money#usage) object, and `rooms_booked` returns an integer.

So we can write a spec to assert the following:

```
Money.new(27000, :gbp) / 3
=> #<Money fractional:9000 currency:GBP>
```

And then ship it!

**But what about infinity?!**

Every good mathematician and Ruby Space Ranger will note that we need to deal
with the classic division by zero problem.

Because if we don't sell any rooms, then our ADR is infinity.

![buzz](https://media.giphy.com/media/5Kje53tstPjpK/giphy-downsized.gif){:class="img-responsive"}

But in reality, it's zero.

So then the first change comes.

```ruby
def average_daily_rate
  rooms_booked == 0 ? 0 : booking_value / rooms_booked
end
```

So now we're checking whether the number of room booked is 0, and if it is we
return 0. If not, we execute our original code.

The above code uses the ternary operator and is the shorthand way of writing:

```ruby
def average_daily_rate
  if rooms_booked == 0
    0
  else
    booking_value / rooms_booked
  end
end
```

The first nice improvement we can make to this code is to use the `zero?`
method given to us by Ruby's Numeric class.

(If you're interested in how we get to use `Numeric`, you can open up irb
and run `1.class.ancestors`, which returns `[Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]`. But this is all for another day.)

So now we've got to this:

```ruby
def average_daily_rate
  rooms_booked.zero? ? 0 : booking_value / rooms_booked
end
```

And I think this is more readable.

Although we do have another problem. And that is this method is now returning
_two types of object_: either a Money object or a Fixnum (the `0`).

Again, this is easily remedied by wrapping the entire thing in `Money.new`.

```ruby
def average_daily_rate
  Money.new(rooms_booked.zero? ? 0 : booking_value / rooms_booked)
end
```

And now this works perfectly. It passes the tests.

**And so this was the exact code presented to me for code review.**

But it nagged at me.

And the reason was that I felt the real _intent_ of the method
(`booking_value / rooms_booked`) was lost at the back of that ternary,
which was now wrapped in the Money initializer.

I come back to this [Four Simple Rules](https://martinfowler.com/bliki/BeckDesignRules.html) post by Martin Fowler every few months,
and those rules for well-designed code still resonate:

1. Passes the tests
2. Reveals intention
3. No duplication
4. Fewest elements

![spongebob](https://media.giphy.com/media/3o7abKhOpu0NwenH3O/giphy.gif){:class="img-responsive"}

Let's look at those one by one:

1. Our method _does_ pass the tests. So that's good.

2. I don't feel it reveals enough intention (it doesn't make the actual ADR algorithm centre-stage).

3. There _is_ duplication because if any rooms are booked, we're
redundantly wrapping a Money object in a Money object. (Ruby Money is smart
enough to handle this, but is still unnecessary.)

4. It's one line of code. Which is cool. But perhaps its brevity is the reason
it is masking intent. Can we make a sensible trade off?

**Removing duplication**

We can remove that duplication easily, by making the zero a Money object.

```ruby
def average_daily_rate
  rooms_booked.zero? ? Money.new(0) : booking_value / rooms_booked)
end
```

**Revealing intent**

How can we ensure the actual ADR algorithm is given centre-stage?

In my opinion, the guard clause is the perfect tool for this job because we are literally guarding ourselves against dividing by zero. Or we execute the very
simple code that we had before complexity started to rear its head.

Here's that refactor:

```ruby
def average_daily_rate
  return Money.new(0) if rooms_booked.zero?
  booking_value / rooms_booked
end
```

And now this feels so much nicer. We escape early to avoid infinity, or we run
the simple division.

**One more thing**

That `Money.new(0)` was bugging me. It's just ugly. And so I jumped into the
console to see if there was a joyous helper class method.

And sure enough, there is a [Money.empty](https://github.com/RubyMoney/money/blob/8484c49ac90bc133eac3e46e37be7194de3e251b/lib/money/money/constructors.rb#L12-L15) concept that aliases as `.zero`.

So our final code looks like this:

```ruby
def average_daily_rate
  return Money.zero if rooms_booked.zero?
  booking_value / rooms_booked
end
```

I adore this refactor. (Which is why I've written about it.) Because the new
code demonstrates why Ruby is such a loved language. It's so readable it almost
looks like pseudo-code you'd show to somebody who doesn't program.

And if we compare it back to:

```ruby
def average_daily_rate
  Money.new(rooms_booked.zero? ? 0 : booking_value / rooms_booked)
end
```

I know which I'd rather read if I was hunting down a bug.

:ocean:
