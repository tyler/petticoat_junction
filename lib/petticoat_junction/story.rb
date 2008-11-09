class PetticoatJunction
  module Story

    private

    def self.included(model)
      model.belongs_to :term
      model.belongs_to :content, :polymorphic => true

      # REFACTORING: "since" feels like it should take a time as an argument.
      model.named_scope :since, lambda { |id|
        { :conditions => ['id > ?', id], :include => :content }
      }
      model.named_scope :after, lambda { |time|
        { :conditions => ['content_created_at > ?', time], :include => :content }
      }
    end
  end
end

