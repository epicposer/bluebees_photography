class Admin::PhotographersController < InheritedResources::Base
  layout 'admin'
  respond_to :html
  actions :show, :edit, :update
  before_filter :authenticate_photographer!
    
  # for javascript notifications
  def destroy
    destroy! do |success, failure|
      success.js { 
        flash[:notice] = 'Successfuly removed the testimonial.'
        render :js => "window.location.reload();"
        return
      }
      failure.js { 
        flash[:alert] = 'Ran into an error removing the testimonial. Please try again.'
        render :js => "window.location.reload();"
        return
      }
    end
  end
    
end