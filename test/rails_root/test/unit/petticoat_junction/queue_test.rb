require File.dirname(__FILE__) + '/../../test_helper'

class PetticoatJunctionQueueTest < ActiveSupport::TestCase
  should "have a list of default queues" do
    assert_instance_of Array, PetticoatJunction::Queue::DEFAULT_QUEUES
  end

  should "have created a queue method on Petticoat" do
    assert PetticoatJunction.respond_to?(:queue)
  end
  
  context "A Queue instance" do
    setup do
      @queue = PetticoatJunction::Queue.new(:foo, :bar)
      PetticoatJunction::STARLING.reset
    end
    teardown { PetticoatJunction::STARLING.reset }

    should 'have a queue_name which matches the ns and the name' do
      assert_equal "#{@queue.ns}_#{@queue.name}", @queue.queue_name
    end

    should 'increase the size of #queue_name queue on #add' do
      before = PetticoatJunction::STARLING.sizeof(@queue.queue_name)
      term = Factory(:term)
      @queue.add term

      assert_equal before + 1, PetticoatJunction::STARLING.sizeof(@queue.queue_name)
    end

    should 'have the methods :<< and :add which are equivalent' do
      assert_equal @queue.method(:<<), @queue.method(:add)
    end

    should 'decrease the size of #queue_name queue on #pop' do
      PetticoatJunction::STARLING.queues(@queue.queue_name => [1])
      before = PetticoatJunction::STARLING.sizeof(@queue.queue_name)
      @queue.pop

      assert_equal before - 1, PetticoatJunction::STARLING.sizeof(@queue.queue_name)
    end

    should_have_instance_variables :@queue, :name, :ns, :queue_name
  end

end
