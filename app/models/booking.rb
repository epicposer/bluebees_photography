class Booking
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title
  field :occurs_on, :type => DateTime
  field :expires_on, :type => DateTime
  field :price_in_cents, :type => Integer
  field :ready, :type => Boolean
  field :description
  
  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false
  
  key :title
  attr_protected :_id
  
  # hierarchical associations
  embedded_in :client, :inverse_of => :bookings
  embeds_many :booking_photos
  
  # virtual price attribute for conversion to cents (stored in cents but can be retrieved and set as dollars)
  def price
    self.price_in_cents.to_f / 100.0 rescue 0
  end
  def price=(price)
    self.price_in_cents = (price.to_f * 100).to_i
  end
  
  # custom selector for comments on child photos
  def comments
    [] # TODO
  end
  
  scope :active, where(:expires_on.gt => Time.now.utc)
  scope :expired, where(:expires_on.lt => Time.now.utc)
  
  def expired?
    if self.expires_on and self.expires_on < Date.today
      return true
    else
      return false
    end
  end
  
end
