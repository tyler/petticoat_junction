require File.dirname(__FILE__) + '/../test_helper'

class TermTest < ActiveSupport::TestCase

  context "a Term" do
    setup { Factory :term }

    should_require_attributes :text
    should_require_unique_attributes :text

    should_have_many :stories
    should_have_many :refreshes
  end

end
