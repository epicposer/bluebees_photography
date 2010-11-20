class GalleryPhoto < Photo
  include ActsAsList::Mongoid
  
  field :pos, :type => Integer
  acts_as_list :column => :pos
  
  # hierarchical associations
  embedded_in :gallery, :inverse_of => :gallery_photos
end