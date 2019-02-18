# Polymorphism in the Real World

You start with Hotels

and then a Hotel has many Reservations.

And this works

Now the Hotel wants a Report.

And so you create a Report.

The Report accepts a Hotel.

Your software becomes a good choice for hotels.

And along comes a Hotel Group. They have five hotels.

All five hotels use your software.

One day the Financial Director of Hotel Group emails and asks you for a report
on how the Hotel Group _as a whole_ is doing.

And so you create a class called GroupReport that accepts a Hotel Group object
and crack on. Gotta make this big customer happy, after all!

Ten minutes into writing your class, it looks like this:

```ruby
class GroupReport
  def initialize(hotel_group)
    @hotel_group = hotel_group
  end

  private

  def reservations
    reservation = []
    @hotel_group.hotels.each do |hotel|
      reservations << hotel.reservations
    end
    reservations
  end
end
```
