require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../mocks/test/mock_service'

class PetticoatJunctionSearchTest < ActiveSupport::TestCase

  should_respond_to 'PetticoatJunction::Search', :start, :stop, :die, :pause

  context 'An instance of PetticoatJunction::Search' do
    setup do
      @search = PetticoatJunction::Search.allocate
      @term = Factory(:term)
    end

    should_respond_to '@search', :churn, :next_term, :search

    should 'raise an error on #search' do
      assert_raise RuntimeError do
        @search.search(@term)
      end
    end
  end  

  context 'An instance of a subclass of PetticoatJunction::Search' do
    setup do
      # don't do #new here... it'll start a #churn thread
      @search = MockService::Search.allocate
      @term = Factory(:term)
    end

    should_respond_to '@search', :churn, :next_term, :search
    
    should 'not raise an error on #search' do
      assert_nothing_raised { @search.search(@term) }
    end
  end
end
