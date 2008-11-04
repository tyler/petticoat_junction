class Term < ActiveRecord::Base
  include PetticoatJunction::Term
  
  validates_presence_of :text
  validates_uniqueness_of :text
end
