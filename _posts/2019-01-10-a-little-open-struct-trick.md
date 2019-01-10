---
layout: default
title: A little OpenStruct trick for working with APIs
---
:tophat:

So you're working with some kind of external API in Ruby.

And you're getting some JSON response that you now want to play with.

```json
{
  "name": "E Street Band",
  "musicians": [
    {
      "name": "Bruce",
      "instrument": "Guitar and Vocals"
    },
    {
      "name": "Clarence",
      "instrument": "Saxophone"
    }
  ]
}
```

So you take the JSON and you parse it.

```ruby
@band = JSON.parse(raw_json)
```

Running `@band.class` tells you it's a `Hash`.

Meaning you can now output the name of the band.

```ruby
@band['name']
# => "E Street Band"
```

Which is okay, and all that. But you're a Rubyist. And so you yearn to write.

```ruby
@band.name
# => "E Street Band"
```

But it doesn't work. And you are sad.

```ruby
@band.name
# => NoMethodError: undefined method `name' for #<Hash:0x007f949c030b00>
```

So you write an API wrapper to solve all your problems.

```ruby
class Band
  def initialize(hash)
    @name = hash['name']
    @musicians = hash['musicians'].map { |musician| Musician.new(musician) }
  end

  attr_reader :name, :musicians
end

class Musician
  def initialize(hash)
    @name = hash['name']
    @instrument = hash['instrument']
  end

  attr_reader :name, :instrument
end
```

Now you can write all your classic Ruby stuff.

```ruby
@band.musicians.map(&:name)
# => ["Bruce", "Clarence"]
```

And you are happier. But still a bit sad. Because those classes feel a bit like
detention.

![My helpful screenshot](/assets/img/simpsons-chalkboard.gif){:class="img-responsive"}

It'd be nice if Ruby could do all that boring stuff for you, eh?

Oh, hi `OpenStruct`! :wave:

`OpenStruct` takes a hash as an initializer argument and gives you back a
lightweight object in return.

```ruby
hash = { cat: 'felix', dog: 'fido' }
# => {:cat=>"felix", :dog=>"fido"}
pet_name_generator = OpenStruct.new(hash)
# => #<OpenStruct cat="felix", dog="fido">
pet_name_generator.cat
# => "felix"
```

Which is pretty cool. And what's cooler is when we inherit from `OpenStruct`.

Because now we can refactor our API wrapper classes into the jaw-droppingly
simple.

```ruby
class Band < OpenStruct
end

class Musician < OpenStruct
end
```

... nearly!

It's not quite that simple because programming is not magic, and it'll blindly assign the array of hashes to the `musicians` method. We want an array of
Musician objects.

But that's okay, because it's trivial to overwrite methods using the
hash syntax to get the object's original value.

Similarly, you can add your own convenience methods using values retrieved from
the API.

Like so.

```ruby
class Band < OpenStruct
  def musicians
    self[:musicians].map { |musician| Musician.new(musician) }
  end
end

class Musician < OpenStruct
  def to_s
    "#{name} on #{instrument}"
  end
end
```

And you can even add a class method to take your JSON.

```ruby
class Band < OpenStruct
  def self.from_json(raw_json)
    new(JSON.parse(raw_json))
  end

  def musicians
    self[:musicians].map { |musician| Musician.new(musician) }
  end
end
```

So now you can bring joy to your codebase.

```ruby
@band = Band.from_json(raw_json)
puts @band.musicians
Bruce on Guitar and Vocals
Clarence on Saxophone
# => nil
```

So if you're writing an API wrapper -- or some other class where it'd be nice to
coerce a hash into an object and perhaps add a few more methods -- then you could
do worse than spending a bit of time dabbling with `OpenStruct`.

:ocean:
