require 'carrierwave/orm/mongoid'
class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  #include ActsAsList::Mongoid

  # associations
  embedded_in :photographer, :inverse_of => :pages

  field :position, :type => Integer
  field :title
  field :intro
  field :body
  field :keywords
  field :slug
  key :slug

  validates_presence_of :title, :intro, :body
  validates_uniqueness_of :title
  validates_length_of :title, :within => 2..100
  validates_length_of :intro, :within => 5..100
  validates_length_of :body, :minimum => 10
  validates_length_of :keywords, :within => 3..200, :allow_blank => true

  attr_protected :_id

  # image
  mount_uploader :image, ImageUploader

  # for permalink (used as the key)
  before_create :build_slug
  def build_slug
    self.slug = self.title.parameterize
  end

end
