class PetticoatJunction
  module Story

    private

    def self.included(model)
      model.belongs_to :term
      model.belongs_to :content, :polymorphic => true

      model.named_scope :since, lambda { |id|
        { :conditions => ['id > ?', id], :include => :content }
      }
      model.named_scope :after, lambda { |time|
        { :conditions => ['content_created_at > ?', time], :include => :content }
      }
    end
  end
end

