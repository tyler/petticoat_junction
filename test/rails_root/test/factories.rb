Factory.sequence(:term_text) { |n| "term#{n}" }
Factory.define :term do |each|
  each.text { Factory.next :term_text }
end