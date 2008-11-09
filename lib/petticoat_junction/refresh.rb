class PetticoatJunction
  module Refresh
    private
    def included(model)
      model.belongs_to :term
    end
  end
end
