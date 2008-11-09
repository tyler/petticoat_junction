require File.dirname(__FILE__) + '/../test_helper'

class FooBarTest < ActiveSupport::TestCase
  should_have_many :stories, :dependent => :destroy
  should_have_many :terms, :through => :stories
end

