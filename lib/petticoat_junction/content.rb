class PetticoatJunction
  module Content

    private
    
    def self.included(model)
      model.has_many :stories, :dependent => :destroy, :as => :content
      model.has_many :terms, :through => :stories
    end
  end
end
