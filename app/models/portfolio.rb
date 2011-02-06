require 'carrierwave/orm/mongoid'
class Portfolio
  include Mongoid::Document
  include Mongoid::Timestamps
  #include ActsAsList::Mongoid

  # associations
  embedded_in :photographer, :inverse_of => :portfolios
  embeds_many :portfolio_photos

  field :position, :type => Integer
  field :title
  field :keywords
  field :description
  field :slug
  key :slug # permalinks

  validates_presence_of :title, :description
  validates_uniqueness_of :title, :case_sensitive => false
  validates_length_of :title, :within => 2..100
  validates_length_of :keywords, :within => 3..200, :allow_blank => true
  validates_length_of :description, :within => 5..1000

  attr_protected :_id

  # cover image
  mount_uploader :cover, CoverUploader

  # for permalink (used as the key)
  before_create :build_slug
  def build_slug
    self.slug = self.title.parameterize
  end

end
