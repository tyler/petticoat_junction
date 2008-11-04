require File.dirname(__FILE__) + '/../../test_helper'

class PetticoatJunctionBaseTest < ActiveSupport::TestCase
  should_respond_to 'PetticoatJunction::Base', :start, :stop, :die
end
