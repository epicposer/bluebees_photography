require 'carrierwave/orm/mongoid'
class Photographer
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :email
  field :phone
  field :site_url
  field :blog_url
  field :facebook_url
  field :twitter_url
  field :blog_url
  field :google_analytics_key
  field :google_verification_key
  field :theme
  field :use_watermark, :type => Boolean, :default => false
  
  validates_presence_of :email, :name, :site_url, :theme
  validates_uniqueness_of :email, :name, :case_sensitive => false
  validates_length_of :name, :within => 3..64
  validates_length_of :email, :within => 5..100, :allow_blank => true
  validates_length_of :phone, :within => 7..20, :allow_blank => true
  validates_length_of :site_url, :within => 10..255
  validates_length_of :blog_url, :within => 10..255, :allow_blank => true
  validates_length_of :facebook_url, :within => 10..255, :allow_blank => true
  validates_length_of :twitter_url, :within => 10..255, :allow_blank => true
  validates_length_of :theme, :within => 2..40
  
  key :name
  attr_protected :_id
  
  # image
  mount_uploader :watermark, WatermarkUploader
end
