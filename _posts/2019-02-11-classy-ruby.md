---
layout: default
title: Classy Ruby (a whole new world of objects)
---
:dancer:

There are a million Ruby tutorials that start with something like this:

```ruby
class Animal

end
```

Yet so few that actually explain what's really going on when we define
a new class.

So after six or so years programming Ruby, I thought I'd take a closer look.

And it turns out the truth is hidden in plain sight.

This is from [the Ruby docs](https://ruby-doc.org/core-2.2.0/Class.html)

> When a new class is created, an object of type Class is initialized
and assigned to a global constant.

After reading that, the *other* way of defining a class now makes
perfect sense.

```ruby
Animal = Class.new
```

But it does beg a whole new bunch of questions.

Like if `Animal` is an instance of a `Class`, then the logical conclusion
is that a **class method** is really just an instance method
on the `Class` object.

But **that's impossible**, right? Because if every user-defined class would be
an instance of the `Class` object, every class method must be instance method on
`Class` itself. there'd be all kinds of naming collisions.

Yeah, that's not what's happening.

So how the devil does Ruby define a class method?

:bomb:

Enter the conceptual minefield of *metaclasses*.

You see, it turns out that when we define our `Animal` class (that initializes
a new instance of `Class`), we also get a magical *second* object that is the
*singleton class* of `Animal`.

It's called a Singleton Class because you can only ever instantiate
**one instance** of it – and hence it's the perfect candidate for defining our
instance method (that will parade around like a class method).

And the beautiful thing about Ruby is proving all this stuff actually happens is
as simple as opening a new `irb` session.

So let's define our class, this time with a class method of `count`.

```ruby
class Animal
  def self.count
    998
  end
end
```

Let's prove `Animal` is an instance of `Class`, it has a singleton class, and
that singleton class has an instance method of count.

```ruby
Animal.class # => Class
Animal.singleton_class # => #<Class:Animal>
Animal.singleton_class.instance_methods.grep(/count/) # => [:count]
```

![doors](https://media.giphy.com/media/l4Ki4tqdPaBWaVDY4/giphy-downsized.gif)

Doing some of this stuff, and poking around in an `irb` session was humbling.
It made me realise how little I knew about a language I thought I had a decent
grasp of. But the joy of learning is that it always comes with the promise of
another season.

:pray:

And so I have heaps of gratitude for the following wonderful things on the
internet:

1. [The Case of the Missing Method](https://www.youtube.com/watch?v=mn2D_k-X-es) –
a talk by [Nadia Odunayo](https://twitter.com/nodunayo)
2. [Ruby has no Class Methods](https://dev.to/edisonywh/ruby-has-no-class-methods-39l5) – an article by [Edison Yap](https://twitter.com/edisonywh)

:ocean:
