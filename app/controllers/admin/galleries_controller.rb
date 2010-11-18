class Admin::GalleriesController < InheritedResources::Base
  layout 'admin'
  respond_to :html, :js
  before_filter :authenticate_admin!
  
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
        flash[:notice] = 'Successfuly removed the gallery.'
        render :js => "window.location.reload();"
        return
      }
      failure.js { 
        flash[:alert] = 'Ran into an error removing the gallery. Please try again.'
        render :js => "window.location.reload();"
        return
      }
    end
  end
  
  protected #----
    def collection
      @galleries ||= end_of_association_chain.all(:sort => 'position')
    end
    
end