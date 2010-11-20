require 'carrierwave/orm/mongoid'
class Photographer
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # :timeoutable
  devise :database_authenticatable, :token_authenticatable, :recoverable, :rememberable, :validatable
  
  field :name
  field :phone
  field :site_url
  field :blog_url
  field :facebook_url
  field :twitter_url
  field :blog_url
  field :google_analytics_key
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
  
  index :email, :unique => true
  attr_protected :_id
  
  # image
  mount_uploader :watermark, WatermarkUploader
  
  before_save :ensure_authentication_token
  
  # returns the path to the theme if one has been set,
  # else returns the default theme path
  def theme_path
    #logger.debug "Previewing theme #{preview}"
    #use_theme = preview.blank? ? theme : preview
    #logger.debug "Using theme: #{use_theme}"
    # set the path to the theme
    path = File.join(RAILS_ROOT, 'themes', theme) unless theme.blank?
    # use the default theme if none has been specified, or if the specified theme doesn't exist
    path = File.join(RAILS_ROOT, 'themes', 'default') if path.blank? or !File.exists?(path)
    return path
  end
  
  # retrieve the available themes
  def self.themes
    found_themes = []
    themes_path = File.join(RAILS_ROOT, 'themes')

    Dir.glob("#{themes_path}/*").each do |theme_dir|
      if File.directory?(theme_dir)
        found_themes << File.basename(theme_dir)
      end
    end

    found_themes
  end
  
end
