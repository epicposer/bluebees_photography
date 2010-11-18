class Testimonial
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid
  
  field :pos, :type => Integer
  field :author
  field :body
  
  validates_presence_of :author, :body
  validates_uniqueness_of :author, :case_sensitive => false
  validates_length_of :author, :within => 5..80
  validates_length_of :body, :within => 5..200
  
  key :author
  attr_protected :_id
  
  acts_as_list :column => :pos
end
