require File.dirname(__FILE__) + '/../test_helper'

class PetticoatJunctionTest < ActiveSupport::TestCase
  should "have a Starling instance" do
    assert_instance_of Starling, PetticoatJunction::STARLING
  end
end
