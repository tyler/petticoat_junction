class PetticoatJunction
  module Term
    %w(viewed_at queued_at searched_at).each do |timestamp|
      define_method("update_#{timestamp}") do |story_type|
        refresh = refreshes.find(:first, :conditions => ['story_type = ?', story_type.to_s])
        refresh = refreshes.create(:story_type => story_type) unless refresh
        refresh.update_attribute(timestamp, Time.now)
      end
    end

    private

    def queue_updates
      PetticoatJunction.queues.each { |type,queues| queues[:new] << self }
    end

    def update_refreshes
      types_needed = ::Refresh::STORY_TYPES - refreshes.map(&:story_type)
      types_needed.each do |type|
        refreshes.create :story_type => type
      end
    end


    def self.included(model)
      model.has_many :refreshes

      model.has_many_polymorphs :contents,
        :from => [:tweets,:videos], 
        :through => :stories

      model.named_scope :need_updated, lambda { |story_type, queued_before, viewed_after|
        { :select => 'terms.id',
          :joins => :refreshes,
          :conditions => ['refreshes.story_type = ? AND ' +
                          '(refreshes.queued_at IS NULL OR ' +
                          ' refreshes.queued_at < ?) AND ' +
                          '(last_viewed_at > ? OR last_viewed_at IS NULL)',
                          story_type.to_s, queued_before, viewed_after] }
      }

      model.after_create :queue_updates
      model.after_save :update_refreshes
    end
  end
end
