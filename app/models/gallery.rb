class Gallery
  include Mongoid::Document
  include Mongoid::Timestamps

  # associations
  embedded_in :photographer, :inverse_of => :galleries
  embeds_many :gallery_photos

  field :title
  field :description
  field :expires_on, :type => DateTime

  validates_presence_of :title
  validates_length_of :title, :within => 2..100
  validates_length_of :description, :within => 5..1000, :allow_blank => true

  attr_protected :_id

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
