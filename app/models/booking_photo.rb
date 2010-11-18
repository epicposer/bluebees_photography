class BookingPhoto < Photo
  # hierarchical associations
  embedded_in :booking, :inverse_of => :booking_photos
  embeds_many :comments
end
