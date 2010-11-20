class BookingPhoto < Photo  
  # associations
  embedded_in :booking, :inverse_of => :booking_photos
  embeds_many :comments
end
