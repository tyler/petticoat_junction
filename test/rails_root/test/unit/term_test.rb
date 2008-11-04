require 'test_helper'

class TermTest < ActiveSupport::TestCase

  context "a Term" do
    setup { Factory :term }

    should_require_attributes :text
    should_require_unique_attributes :text
  end

end
