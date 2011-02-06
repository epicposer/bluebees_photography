require 'carrierwave/orm/mongoid'
class Photographer
  include Mongoid::Document
  include Mongoid::Timestamps

  # associations
  embeds_many :galleries
  embeds_many :portfolios
  embeds_many :pages

  # Include devise modules. Others available are:
  # :token_authenticatable, :timeoutable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :confirmable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  field :name
  field :phone
  field :site_url
  field :blog_url
  field :facebook_url
  field :twitter_url
  field :google_analytics_key
  field :theme, :default => 'default'
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

  # retrieve the available themes
  def self.themes
    found_themes = []
    themes_path = File.join(Rails.root, 'themes')

    Dir.glob("#{themes_path}/*").each do |theme_dir|
      if File.directory?(theme_dir)
        found_themes << File.basename(theme_dir)
      end
    end

    found_themes
  end

end
