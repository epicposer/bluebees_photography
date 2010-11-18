class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false
  
  # hierarchical associations
  embedded_in :booking_photo, :inverse_of => :comments
end
