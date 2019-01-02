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

But **that's impossible** because every user defined class is an instance of the
`Class` object, and so there'd be all kinds of naming collisions.

So how the devil does Ruby define a class method?

:bomb:

Enter the conceptual minefield of *metaclasses*.

You see, it turns out that when we define our Animal class (that initializes
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
