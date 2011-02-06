class Photog::PortfolioPhotosController < Photog::HomeController
  inherit_resources
  respond_to :html, :json, :js
  skip_before_filter :authenticate_photographer!, :only => :flash_upload
  skip_before_filter :verify_authenticity_token, :only => :flash_upload
  belongs_to :portfolio

  # Redirect to collection path on create.
  def create; create!{ collection_path }; end;

  # Redirect to collection path on update.
  def update; update!{ collection_path }; end;

  # Uploadify integration for multiple uploads at once.
  def flash_upload
    # validate the token param
    if params[:token]
      # find the photographer by token
      return unless Photographer.where(:authentication_token => params[:token]).first
      portfolio = Portfolio.find(params[:portfolio_id])
      portfolio_photo = portfolio.portfolio_photos.create!(params[:portfolio_photo])
      # need to assign the correct content type becuase this is missing from a flash upload
      #portfolio_photo.photo.content_type = MIME::Types.type_for(portfolio_photo.photo.filename).to_s
      if portfolio_photo
        render :json => {:title => 'Success', :message => 'Photo was successfuly created.', :id => portfolio_photo.id}
      else
        logger.debug "#{portfolio_photo.errors.inspect}"
        render :json => {:title => 'Error', :message => 'Ran into a problem uploading your photo.'}
      end
    else
      logger.error "Invalid token: #{params[:token]}"
      render :json => {:title => 'Error', :message => 'Ran into a security problem uploading your photo.'}, :layout => nil
    end
  end

  # Update the position. - TODO fix this
  def update_position
    begin
      @portfolio = current_photographer.portfolios.find(params[:portfolio_id])
      logger.debug("Found portfolio: #{@portfolio.id}")
      portfolio_photo = @portfolio.portfolio_photos.find(params[:id]) # grab the object
      logger.debug("Found portfolio photo: #{portfolio_photo.id}")
      logger.debug("Move to position: #{params[:position]}")
      portfolio_photo.move(:to => params[:position].to_i) # update the object's order
      render :json => {:title => 'Success', :message => 'The order was updated successfuly.'}
    rescue
      logger.error $ERROR_INFO.inspect
      render :json => {:title => 'Error', :message => 'Ran into an error updating the order. Please try again.'}
    end
  end

  private #----

    # Sort the collection.
    def collection
      @portfolio_photos ||= end_of_association_chain.asc(:position)
    end

end