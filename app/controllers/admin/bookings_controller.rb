class Admin::BookingsController < InheritedResources::Base
  layout 'admin'
  actions :all, :except => :show
  respond_to :html, :js
  belongs_to :client
  before_filter :authenticate_photographer!
  
  def new
    new! {
      @booking.occurs_on = 2.weeks.from_now.utc
      @booking.expires_on = 4.weeks.from_now.utc
    }
  end
  
  # redirect to collection path
  def create
    create! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end
  def update
    update! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end
  
  # for javascript notifications
  def destroy
    destroy! do |success, failure|
      success.js { 
        flash[:notice] = 'Successfuly removed the booking.'
        render :js => "window.location.reload();"
        return
      }
      failure.js { 
        flash[:alert] = 'Ran into an error removing the booking. Please try again.'
        render :js => "window.location.reload();"
        return
      }
    end
  end
  
  protected #----
    def collection
      @bookings ||= end_of_association_chain.order_by(:created_at.desc)
    end
    
end

