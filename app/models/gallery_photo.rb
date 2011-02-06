class GalleryPhoto < Photo
  # associations
  embedded_in :gallery, :inverse_of => :gallery_photos
end
