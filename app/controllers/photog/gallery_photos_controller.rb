class Photog::GalleryPhotosController < Photog::HomeController
  inherit_resources
  respond_to :html, :json, :js
  skip_before_filter :authenticate_photographer!, :only => :flash_upload
  skip_before_filter :verify_authenticity_token, :only => :flash_upload
  belongs_to :client, :gallery

  def ajax_row
    @client = Client.find(params[:client_id])
    @gallery = @client.galleries.find(params[:gallery_id])
    @gallery_photo = @gallery.gallery_photos.find(params[:id])
    render 'photog/gallery_photos/ajax_row.html.haml', :layout => nil
  end

  def flash_upload
    # validate the token param
    if params[:token]
      # find the photographer by token
      return unless Photographer.where(:authentication_token => params[:token]).first
      @client = Client.find(params[:client_id])
      @gallery = @client.galleries.find(params[:gallery_id])
      @gallery_photo = @gallery.gallery_photos.create!(params[:gallery_photo])
      # need to assign the correct content type becuase this is missing from a flash upload
      #gallery_photo.photo.content_type = MIME::Types.type_for(gallery_photo.photo.filename).to_s
      if @gallery_photo
        render :json => {:title => 'Success', :message => 'Photo was successfuly created.', :id => @gallery_photo.id}
      else
        logger.debug "#{@gallery_photo.errors.inspect}"
        render :json => {:title => 'Error', :message => 'Ran into a problem uploading your photo.'}
      end
    else
      logger.error "Invalid token: #{params[:token]}"
      render :json => {:title => 'Error', :message => 'Ran into a security problem uploading your photo.'}, :layout => nil
    end
  end

  # javascript notifications
  def destroy
    destroy! do |success, failure|
      success.js {
        flash[:notice] = nil
        render :json => {:title => 'Success', :message => 'Photo was successfuly removed.'}
      }
      failure.js { render :json => {:title => 'Error', :message => 'Ran into an error removing the photo. Please try again.'} }
    end
  end

  private #----
    def collection
      @gallery_photos ||= end_of_association_chain.desc(:created_at)
    end

end