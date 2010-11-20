class Admin::BookingPhotosController < InheritedResources::Base
  layout 'admin'
  respond_to :html, :js
  before_filter :authenticate_photographer!, :except => :flash_upload
  skip_before_filter :verify_authenticity_token, :only => :flash_upload
  belongs_to :client, :booking
  
  def ajax_row
    @client = Client.find(params[:client_id])
    @booking = @client.bookings.find(params[:booking_id])
    @booking_photo = @booking.booking_photos.find(params[:id])
    render 'admin/booking_photos/ajax_row.html.haml', :layout => nil
  end
  
  def flash_upload
    # validate the token param
    if params[:token]
      # find the photographer by token
      return unless Photographer.where(:authentication_token => params[:token]).first
      @client = Client.find(params[:client_id])
      @booking = @client.bookings.find(params[:booking_id])
      @booking_photo = @booking.booking_photos.create!(params[:booking_photo])
      # need to assign the correct content type becuase this is missing from a flash upload
      #booking_photo.photo.content_type = MIME::Types.type_for(booking_photo.photo.filename).to_s
      if @booking_photo
        render :json => {:title => 'Success', :message => 'Photo was successfuly created.', :id => @booking_photo.id}
      else
        logger.debug "#{@booking_photo.errors.inspect}"
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
      @booking_photos ||= end_of_association_chain.order_by(:created_at.desc)
    end
    
end