require 'carrierwave/orm/mongoid'
class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid
  
  field :pos, :type => Integer
  field :title
  field :intro
  field :body
  field :keywords
  
  validates_presence_of :title, :intro, :body
  validates_uniqueness_of :title
  validates_length_of :title, :within => 2..100
  validates_length_of :intro, :within => 5..100
  validates_length_of :body, :minimum => 10
  validates_length_of :keywords, :within => 3..200, :allow_blank => true
  
  key :title
  attr_protected :_id
  
  acts_as_list :column => :pos
  
  # image
  mount_uploader :image, ImageUploader
end
