class Admin::GalleryPhotosController < InheritedResources::Base
  layout 'admin'
  respond_to :html, :js
  before_filter :authenticate_photographer!, :except => :flash_upload
  skip_before_filter :verify_authenticity_token, :only => :flash_upload
  belongs_to :gallery
  
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
        render :json => {:title => 'Success', :message => 'Photo was successfuly removed.'} 
      }
      failure.js { render :json => {:title => 'Error', :message => 'Ran into an error removing the photo. Please try again later.'} }
    end
  end
  
  
  def flash_upload
    # validate the token param
    if params[:token]
      # find the photographer by token
      return unless Photographer.where(:authentication_token => params[:token]).first
      gallery = Gallery.find(params[:gallery_id])
      gallery_photo = gallery.gallery_photos.create!(params[:gallery_photo])
      # need to assign the correct content type becuase this is missing from a flash upload
      #gallery_photo.photo.content_type = MIME::Types.type_for(gallery_photo.photo.filename).to_s
      if gallery_photo
        render :json => {:title => 'Success', :message => 'Photo was successfuly created.', :id => gallery_photo.id}
      else
        logger.debug "#{gallery_photo.errors.inspect}"
        render :json => {:title => 'Error', :message => 'Ran into a problem uploading your photo.'}
      end
    else
      logger.error "Invalid token: #{params[:token]}"
      render :json => {:title => 'Error', :message => 'Ran into a security problem uploading your photo.'}, :layout => nil
    end
  end
  
  # update an individual gallery photo's position
  def update_position
    begin
      @gallery = Gallery.find(params[:gallery_id])
      logger.debug("Found gallery: #{@gallery.id}")
      gallery_photo = @gallery.gallery_photos.find(params[:id]) # grab the object
      logger.debug("Found gallery photo: #{gallery_photo.id}")
      logger.debug("Move to position: #{params[:position]}")
      gallery_photo.move(:to => params[:position].to_i) # update the object's order
      render :json => {:title => 'Success', :message => 'The order was updated successfuly.'}
    rescue
      logger.error $ERROR_INFO.inspect
      render :json => {:title => 'Error', :message => 'Ran into an error updating the order. Please try again.'}
    end
  end
  
  private #----
    def collection
      @gallery_photos ||= end_of_association_chain.order_by(:pos.asc)
    end
    
end