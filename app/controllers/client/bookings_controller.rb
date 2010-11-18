class Client::BookingsController < InheritedResources::Base
  layout 'client'  
  actions :index
  respond_to :html
  
  before_filter :authenticate_client!
  before_filter :require_active_bookings!
  
  private #-------
    def begin_of_association_chain
      @current_client
    end
    
    # Defining the collection explicitly for filtering
    def collection
      #@bookings = current_client.bookings.where(:expires_on.gte => Time.now.utc).order_by(:created_at.desc)
      @bookings ||= end_of_association_chain.where(:expires_on.gte => Time.now.utc).order_by(:created_at.desc)
    end
     
end
