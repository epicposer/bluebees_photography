require 'carrierwave/orm/mongoid'
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :slug
  key :slug
  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false

  attr_protected :_id

  # image
  mount_uploader :photo, PhotoUploader

  # build the title from the file name if one wasn't provided
  before_validation :set_title
  def set_title
    # if no title has been set, use the image's file name but spruce it up a little
    self.title = photo.filename[0, photo.filename.rindex('.')].humanize.titleize if title.blank? and !photo.filename.blank?
  end

  # for permalink (used as the key)
  before_create :build_slug
  def build_slug
    self.slug = self.title.parameterize
  end

end
