class Foo < PetticoatJunction
  model :foo_bars

  class Monitor < PetticoatJunction::Monitor
    rate :active, :threshold => 4.minutes, :refresh => 3.minutes
    rate :stale, :threshold => 2.days, :refresh => 40.minutes
  end

  class Search < PetticoatJunction::Search
    pause 1.second

    def search(term)
      text = term.text + Time.now.to_i.to_s
      foobar = FooBar.create :text => text
      term.stories.create :content => foobar, :content_created_at => Time.now
    end
  end
end
