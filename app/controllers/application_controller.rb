class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'devise' # for authentication
    else
      'application' # default
    end
  end

  helper_method :active_photographer

  private #-----

    # retrieve photographer information so it can be used on every template and layout
    def active_photographer
      return @active_photographer if defined?(@active_photographer)
      begin
        @active_photographer = Photographer.first
      rescue Exception => e
        flash[:error] = e.message
        redirect_to config_error_path
        return
      end
    end

    def active_theme
      active_photographer.theme
    end

end
