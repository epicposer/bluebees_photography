class Client::BookingsController < InheritedResources::Base
  actions :index
  respond_to :html
  
  # this removes the layout for all ajax requests
  layout proc { |controller| controller.request.xhr? ? nil : 'client' }
  
  before_filter :authenticate_client!
  before_filter :require_active_bookings!
  
  private #-------
    # Defining the collection explicitly for filtering
    def collection
      @bookings = current_client.bookings.find :all, :conditions => "expires_on IS NULL OR expires_on > '#{Date.today}'", :order => 'created_at'
    end
     
end
