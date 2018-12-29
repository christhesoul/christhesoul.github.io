---
layout: default
title: Selecting hams – a tiny guide to rolling your own Enumerables
---
:meat_on_bone:

One of my recent obsessions is the work of Sandi Metz.

Sandi is highly-regarded in the Ruby community, and is an authority on
object-oriented programming.

There is so much clarity of thought in her writing and speaking. I'm
inspired by how she makes refactoring brittle, bloated code seem so immediately achievable.

But as with everything, the easiest way to appreciate the skill of an expert is
to try achieving a similar level of quality in your own work. And it's very hard.

Nevertheless, we can only try.

One of Sandi's more frequent topics is polymorphism, and how this is
an affordance of object-oriented programming.

(And by affordance, we mean that the design of the language suggests how we
should be using it. A teapot affords being picked up and tipped because the
handle is on the opposite side to the spout. OO affords polymorphism
because different objects can be sent the very same message.)

```ruby
class CuredMeat
  attr_reader :name, :origin

  def initialize(name, origin)
    @name = name
    @origin = origin
  end
end
```

```ruby
class Charcuterie
  include Enumerable

  INVENTORY = [
    ['Sausage', 'Germany'],
    ['Speck ham', 'Italy'],
    ['Chorizo', 'Spain'],
    ['Salami', 'Italy'],
    ['Prosciutto', 'Italy'],
    ['Iberico ham', 'Spain'],
    ['Serrano ham', 'Spain']
  ]

  def initialize
    @meats =
      INVENTORY.sample(4).to_h.map do |name, origin|
        CuredMeat.new(name, origin)
      end
  end

  def each(&block)
    @meats.each(&block)
  end
end
```
