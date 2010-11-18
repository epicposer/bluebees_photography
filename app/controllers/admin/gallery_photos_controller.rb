class Admin::GalleryPhotosController < InheritedResources::Base
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
        flash[:notice] = 'Successfuly removed the photo.'
        render :js => "window.location.reload();"
        return
      }
      failure.js { 
        flash[:alert] = 'Ran into an error removing the photo. Please try again.'
        render :js => "window.location.reload();"
        return
      }
    end
  end
  
  protected #----
    def collection
      @gallery_photos ||= end_of_association_chain.all(:sort => 'position')
    end
    
end