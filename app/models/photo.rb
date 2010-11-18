require 'carrierwave/orm/mongoid'
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title

  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false
  
  key :title
  attr_protected :_id
  
  # image
  mount_uploader :photo, PhotoUploader
  
  before_validation :set_title
  
  def set_title
    # if no title has been set, use the image's file name but spruce it up a little
    self.title = photo.filename[0, photo.filename.rindex('.')].humanize.titleize if title.blank? and !photo.filename.blank?
  end
end
