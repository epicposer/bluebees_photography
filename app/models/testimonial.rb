class Testimonial
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid
  
  field :pos, :type => Integer
  field :author
  field :slug
  field :body
  
  validates_presence_of :author, :body
  validates_uniqueness_of :author, :case_sensitive => false
  validates_length_of :author, :within => 5..80
  validates_length_of :body, :within => 5..200
  
  key :slug
  attr_protected :_id
  
  acts_as_list :column => :pos
  
  # for permalink (used as the key)
  before_create :build_slug
  def build_slug
    self.slug = self.author
  end
end
