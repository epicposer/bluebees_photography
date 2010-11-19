class Admin::TestimonialsController < InheritedResources::Base
  layout 'admin'
  respond_to :html, :js
  actions :all, :except => :show
  before_filter :authenticate_photographer!
  
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
  
  # javascript notifications
  def destroy
    destroy! do |success, failure|
      success.js { 
        flash[:notice] = nil
        render :json => {:title => 'Success', :message => 'Testimonial was successfuly removed.'} 
      }
      failure.js { render :json => {:title => 'Error', :message => 'Ran into an error removing the testimonial. Please try again.'} }
    end
  end
  
  # check ownership and update an individual testimonial's position
  def update_position
    begin
      testimonial = Testimonial.find(params[:id])
      testimonial.move(:to => params[:position].to_i) # update the object's order
      render :json => {:title => 'Success', :message => 'The order was updated successfuly.'}
    rescue
      render :json => {:title => 'Error', :message => 'Ran into an error updating the order. Please try again.'}
    end
  end
  
  protected #----
    def collection
      @testimonials ||= end_of_association_chain.order_by(:pos.asc)
    end
    
end