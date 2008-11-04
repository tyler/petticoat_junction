require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../mocks/test/mock_service'

class PetticoatJunctionMonitorTest < ActiveSupport::TestCase
  should_respond_to 'PetticoatJunction::Monitor', :start, :stop, :die

  context 'An instance of a subclass of Petticoat::Monitor' do
    setup do
      # don't do #new here... it'll start a #churn thread
      @monitor = MockService::Monitor.allocate

      term = Factory(:term)
      term.update_attributes(:last_viewed_at => 4.minutes.ago)
      term.refreshes.create(:story_type => 'mock_service', :queued_at => 3.minutes.ago)

      @term = Factory(:term)
      @term.update_attributes(:last_viewed_at => 10.minutes.ago)
      @term.refreshes.create(:story_type => 'mock_service', :queued_at => 3.minutes.ago)
    end

    should 'find only the applicable terms' do
      terms = @monitor.send(:latest_terms, :refresh => 2.minutes, :threshold => 5.minutes)
      assert_equal 1, terms.size
    end

    should 'have a namespace matching the namespace of its class' do
      assert_equal :mock_service, @monitor.namespace
    end

    should 'increment the size of the correct queue on #add_to_queue' do
      before = PetticoatJunction::STARLING.sizeof('mock_service_active')
      @monitor.send :add_to_queue, :active, [@term]

      assert_equal before + 1, PetticoatJunction::STARLING.sizeof('mock_service_active')
    end

    should 'survive multiple cycles of #churn' do
      churn = Thread.new { @monitor.send(:churn) }
      sleep 0.5

      assert churn.alive?

      churn.kill
    end
  end
end
