class HomeController < ApplicationController
  theme :active_theme

  def config_error
    render :layout => false, :template =>  '/config_error.html'
  end

  # landing page
  def index
    @page_title = active_photographer.name
    @portfolios = active_photographer.portfolios.asc(:position)
    render :template => '/home'
  end

  def not_found
    render :template => '/404', :status => :not_found
  end

  private #------



end