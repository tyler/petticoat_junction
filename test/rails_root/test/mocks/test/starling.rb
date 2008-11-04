class Starling
  
  # Mock methods

  def initialize(server)
    @server = server
    @queues = {}
  end

  def set(queue, value)
    @queues || reset
    @queues[queue] ||= []
    @queues[queue].push value
  end

  def fetch(queue)
    @queues || reset
    @queues[queue] && @queues[queue].shift
  end

  def sizeof(queue)
    @queues || reset
    return 0 unless @queues[queue]
    @queues[queue].size
  end


  # Test Utility methods

  def reset
    @queues = {}
  end

  def queues(q)
    @queues = q
  end
end
