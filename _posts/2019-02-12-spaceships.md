---
layout: default
title: Spaceships in Ruby
---
:alien:

There are plenty of cool things about Ruby. And the so called
**Spaceship Operator** (because `<=>` looks like a spaceship, obvs)
is definitely one of the coolest.

But what does it do?

The `<=>` operator returns 1, 0, or -1 depending on the comparison.

- `1` if the value on the left is greater than the value on the right
- `0` if the two values are considered equal
- `-1` if the value on the right is considered greater

So far, so good.

### Launching the spaceship

When dealing with Numeric object, this is pretty obvious.

```ruby
100 <=> 99   # returns 1
 99 <=> 99   # returns 0
 99 <=> 100  # returns -1
```

It's less obvious when dealing with Strings.

```ruby
"boys" <=> "girls" # returns -1 ("girls" wins)
```

Don't be fooled into thinking girls are better than boys because there's more
of them. (Characters, I mean.)

```ruby
"big boys" <=> "girls" # returns -1 ("girls" wins)
```

Ruby is actually comparing them on an alphabetical basis. The `g` being greater
than the `b`.

What's more, case matters. `b` is greater than `G` (as `A..Za..z` is the logical
way to approach this).

```ruby
"boys" <=> "Girls" # returns 1 ("boys" wins)
```

And you can put all this together by using `Array#sort` because under the hood
`.sort` is using the spaceship.

```ruby
["boys", "girls", "Girls"].sort
 # => ["Girls", "boys", "girls"]
 ```

### Comparing your own objects

The spaceship operator isn't limited to Ruby's standard library.

Take this tiny `Song` class:

```ruby
class Song
  def initialize(name)
    @name = name
  end
end
```

And since we've got Girls and Boys on the brain, let's go back to the great
Oasis vs Blur chart battle of 1995.

Deciding which song was better is now trivial using Ruby's sort, right?

```ruby
[Song.new('Country House'), Song.new('Roll With It')].sort
```

Nope!

```ruby
ArgumentError (comparison of Song with Song failed)
```

![dammit](https://media.giphy.com/media/cwyEMPn54Juxi/giphy-downsized.gif)

The reason for this `ArgumentError` is that we haven't told Ruby *how* to
compare these two songs. Doing so requires us to implement the `<=>` operator.

So let's implement the spaceship operator in our class

```ruby
class Song
  attr_reader :name, :sales

  def initialize(name, sales)
    @name = name
    @sales = sales
  end

  def <=> (song)
    sales <=> song.sales
  end
end
```

run the comparison again with same sales figures

```ruby
[
  Song.new('Country House', 274_000),
  Song.new('Roll With It', 214_000)
].sort.map(&:name)
```

and see the correct answer:

```ruby
["Roll With It", "Country House"]
```

Of course, this wasn't how the charts looked in 1995 because Ruby's number sort
goes from low to high.

![fozzy](https://media.giphy.com/media/oV4DOTSXRhRMA/giphy-tumblr.gif)

However, if you're desperate to see Blur come out victorious again, then you
can now include the `Comparable` module in your class (which uses `<=>` to give
you access to your favourite comparison operators such as `>` and `<`).

So now your class looks like this:

```ruby
class Song
  include Comparable

  attr_reader :name, :sales

  def initialize(name, sales)
    @name = name
    @sales = sales
  end

  def <=> (song)
    sales <=> song.sales
  end
end
```

You're desperate for proof that

```ruby
Song.new('Country House', 274_000) > Song.new('Roll With It', 214_000)
```
And you get it:

```ruby
true
```

![country house](https://media.giphy.com/media/pJyHYefeyuFhe/giphy.gif)

:ocean:
