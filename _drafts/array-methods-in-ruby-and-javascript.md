---
layout: default
title: Array methods in Ruby and Javascript
---
:sheep:

I'm not as good as Javascript as I should be. And it's always frustrating because I'm sat there knowing that I could solve my problem if only I could write Ruby.

So here is a cheat sheet for myself when I want to do something with a Javascript array.

If you'd like to run these examples yourself:

Run the **Ruby** ones in an irb session. (Open Terminal on a Mac, and type `irb`.)

Run the **Javascript** ones in a browser console. (Open Chrome on a Mac, and select View > Developer > Javascript Console.)

### .each in Ruby :arrow_right: .forEach in Javascript

These methods simply iterate over each item in an array and execute the code in the block (Ruby) or arrow function (JS).

#### Ruby
```ruby
['Cow', 'Dog', 'Sheep'].each { |animal| puts animal }
```
#### Javascript
```js
['Cow', 'Dog', 'Sheep'].forEach(animal => console.log(animal))
```

### .map in Ruby :arrow_right: .map in Javascript

These methods return a new array based on the result of executing the code. So our examples below will both return `[2, 4, 6]`.

#### Ruby
```ruby
[1, 2, 3].map { |n| n * 2 }
```

#### Javascript
```js
[1, 2, 3].map(n => n * 2)
```

### .select in Ruby :arrow_right: .filter in Javascript

#### Ruby
```ruby
[1, 2, 3, 4].select { |n| n % 2 == 0 }
```

#### Javascript
```js
[1, 2, 3, 4].filter(n => n % 2 == 0)
```

### .detect in Ruby :arrow_right: .find in Javascript

### .any? in Ruby :arrow_right: .some in Javascript

### .all? in Ruby :arrow_right: .every in Javascript
