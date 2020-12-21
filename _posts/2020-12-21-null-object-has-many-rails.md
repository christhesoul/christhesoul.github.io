---
layout: default
title: A Null Object Has Many implementation for Rails
bg-color: washed-yellow
---

**Just because you _can_ do something doesn't mean you should.**

But sometimes I rather like Null Objects. They can preserve the integrity of the rest of your application by removing the need to presence check or litter views with safe navigation operators.

But when your null objects are standing in for mature ActiveRecord models, sometimes things can get a bit hairy.

Consider a `Restaurant` that `has_many :reviews`. The majority of the time, you'll be working with a real Restaurant. But there are edge cases where you won't – and perhaps you'll need to reach for the null object toolbox and pull out a `NilRestaurant`.

The awesome folks at [thoughtbot](https://thoughtbot.com/blog/handling-associations-on-null-objects) have written about null object relationships, and how [Relation#none](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-none) will give you a scope-friendly empty results set.

So now you can define

```ruby
class NilRestaurant
  def reviews
    Review.none
  end
end
```

And this is a wonderfully pleasant solution.

But your app grows and grows. And now you don't only review restaurants, but you also garner opinions on hotels too.

Rails gives you the sweetness of polymorphism. And because you've had "composition over inheritance" drilled into you for as long as you can remember, you also harness the power of Concerns.

And so your `Reviewable` concern looks a bit like this:

```ruby
module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable, dependent: :destroy
  end

  def review_score
    reviews.average(:score)
  end
end
```

This means you can simply `include Reviewable` in your `Restaurant` and `Hotel` models.

But what about `NilRestaurant` and `NilHotel`?

Sure, you could define `reviews` and `review_score` in those classes. But what if you could `include Reviewable` in those classes too?

The only issue with doing this is that a plain old Ruby class has no idea what to do with `has_many`.

And so we can teach it:

```ruby
class NilBase
  class << self
    def has_many(relation, *options)
      define_method relation do
        relation.to_s.singularize.classify.constantize.send(:none)
      end
    end
  end
end
```

This will see a `NilBase` instance defining a `reviews` method that returns `Review.none`.

You can then have `NilRestaurant` and `NilHotel` inherit from `NilBase`.

And so any `has_many` definitions that follow naming conventions will now return a null relation.

Just because you _can_ do something doesn't mean you should.

But it's sometimes fun to try.
