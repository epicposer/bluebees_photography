class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_photographer
  
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'devise' # for amin sigin
    else
      'layout' # default
    end
  end
  
  private #-----
  
    # retrieve photographer information so it can be used on every template and layout
    def load_photographer
      return @photographer if defined?(@photographer)
      begin
        @photographer = Photographer.first
      rescue Exception => e
        flash[:error] = e.message
        redirect_to config_error_path
        return
      end
    end
    
    def require_active_bookings!
      logger.debug "checking for bookings"
      unless current_client.has_active_bookings?
        flash[:notice] = "You currently have no active bookings in the system."
        redirect_to client_error_path
        return
      end
    end
    
    # just using basic auth for the admin section
    #def authenticate_admin!
    #  authenticate_or_request_with_http_basic do |email, password|
    #    email == @photographer.email && password == @photographer.password
    #  end if RAILS_ENV == 'production' || params[:admin_http]
    #end
    
end
