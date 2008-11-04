class MockService < PetticoatJunction
  class Monitor < PetticoatJunction::Monitor
    rate :active, :refresh => 2.minutes, :threshold => 5.minutes
    rate :stale, :refresh => 45.minutes, :threshold => 2.days

    @@pause = 0.1
  end

  class Search < PetticoatJunction::Search
    def search(term)
      
    end
  end
end
