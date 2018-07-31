require('pry')
require_relative("models/space_cowboy")

SpaceCowboy.delete_all()

space_cowboy1 = SpaceCowboy.new(
  {
    'name' => 'Han Solo',
    'species' => 'Human',
    'bounty_value' => '5000',
    'homeworld' => 'Corellia'
  }
)

space_cowboy2 = SpaceCowboy.new(
  {
    'name' => 'Chewbacca',
    'species' => 'Wookie',
    'bounty_value' => '2500',
    'homeworld' => 'Kashyyk'
  }
)

space_cowboy1.save()
space_cowboy2.save()

p SpaceCowboy.find_by_id(61)
