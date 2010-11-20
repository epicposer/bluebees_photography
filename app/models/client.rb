class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # :token_authenticatable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable
  
  field :name
  field :slug
  field :phone
  field :street1
  field :street2
  field :city
  field :province_state
  field :country
  field :mail_code
  
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false
  validates_length_of :phone, :within => 7..20, :allow_blank => true
  validates_length_of :street1, :within => 3..128, :allow_blank => true
  validates_length_of :street2, :within => 3..64, :allow_blank => true
  validates_length_of :city, :within => 3..64, :allow_blank => true
  validates_length_of :province_state, :is => 2, :allow_blank => true
  validates_length_of :country, :within => 3..32, :allow_blank => true
  validates_length_of :mail_code, :within => 5..20, :allow_blank => true
  
  index :email, :unique => true
  key :slug
  attr_protected :_id
  
  # hierarchical associations
  embeds_many :bookings
  references_many :comments, :inverse_of => :client
  
  before_validation :password_confirmation_workaround
  
  # haven't figured out a way to simple disable it in devise easily, so here's our hack.
  def password_confirmation_workaround
    self.password_confirmation = self.password
  end
  
  def has_active_bookings?
    self.bookings.active.size > 0
  end
  
  # for permalink (used as the key)
  before_create :build_slug
  def build_slug
    self.slug = self.name.parameterize
  end
end
