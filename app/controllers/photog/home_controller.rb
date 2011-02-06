class Photog::HomeController < ApplicationController
  layout 'photog'
  before_filter :authenticate_photographer!

  # Dashboard
  def index
  end

end