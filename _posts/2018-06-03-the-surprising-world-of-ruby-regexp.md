---
layout: default
title: The surprising world of Ruby's Regexp
---
:thinking:

One of the joys of open source code is being able to dive right into the answer when you find yourself wondering "how did they go about building that?".

While writing about Jekyll's Front Matter yesterday, I was intrigued as to how they'd gone about stripping the YAML out of the start of the doc to parse it.

After a bit of searching, I found [this little hunk of code](https://github.com/jekyll/jekyll/blob/035ea729ff5668dfc96e7f56a86d214e5a633291/lib/jekyll/convertible.rb#L43-L45):

```ruby
if content =~ Document::YAML_FRONT_MATTER_REGEXP
  self.content = $POSTMATCH
  self.data = SafeYAML.load(Regexp.last_match(1))
end
```

Now, if the truth be told, I tend to steer clear of Regular Expressions. We seldom use regex in our day to day work, so I've managed to get by without memorising the mind-boggling syntax. I take my hat off to those who can write regex without breaking a sweat.

As such, a few things in this code required some further research

1. `=~` some kind of matcher?
2. `$POSTMATCH` some kind of global var?
3. `Regexp.last_match(1)` WTF?

The reason `3.` was such a WTF? is because it's clearly a class method. But where's the instance of the match? What's happening? Where am I? :scream:

Okay. Let's see if we can figure any of this stuff out.

#### 1. The `=~` operator

From [Ruby Quicktips](http://rubyquicktips.com/post/15994276561/the-and-operators) :point_down:

> The operator =~ matches a String against a regular expression pattern. It returns the position/index where the String was matched - or nil if no match was found.

Okay, so this is simple enough to understand.

```ruby
"racecar" =~ /e/
=> 3

"racecar" =~ /f/
=> nil
```

And because it returns nil, it can be used within an `if` statement as a check for whether a pattern exists in a string.

#### 2. The `$POSTMATCH` variable

So here's where things become fascinating: immediately after evaluating whether a pattern exists in a string, I have access to a local variable (that looks like a global variable) called `$POSTMATCH`.

```ruby
"racecar" =~ /e/
=> 3

$POSTMATCH
=> "car"
```

And so the curious would immediately look to see if `$PREMATCH` exists, too. And it does. As does `$MATCH`.

```ruby
"racecar" =~ /e/
=> 3

$PREMATCH
=> "rac"

$MATCH
=> "e"

$POSTMATCH
=> "car"
```

Nice.

#### 3. The `Regexp.last_match` class method

Now we know there are some global-esque variables hanging around, this class method makes a lot more sense.

It also reveals the presence of an object called `MatchData` that exists with every successful pattern match, and encapsulates all its results.

This `MatchData` object also available through the wonderfully obscure `$~` variable.

The `.last_match` class method returns the `MatchData` object, and when called with a argument, returns nth field in this object.

```ruby
"racecar" =~ /e/
=> 3

$~
=> #<MatchData "e">

Regexp.last_match
=> #<MatchData "e">

Regexp.last_match(0)
=> "e"

Regexp.last_match(1)
=> nil
```

And that clears that up. Perhaps. I guess I was surprised at this kind of design as it's like nothing else I've seen in Ruby. But perhaps I haven't been looking long and hard enough.

:ocean:
