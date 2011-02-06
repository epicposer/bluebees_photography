class Photog::PagesController < Photog::HomeController
  inherit_resources
  respond_to :html, :json, :js
  actions :all, :except => :show

  # Redirect to collection path on create.
  def create; create!{ collection_path }; end;

  # Redirect to collection path on update.
  def update; update!{ collection_path }; end;

  # Update the position - TODO fix this
  def update_position
    begin
      page = current_photographer.pages.find(params[:id]) # grab the object
      page.insert_at(params[:position].to_i) # update the object's order
      render :json => {:title => 'Success', :message => 'The order was updated successfuly.'}
    rescue
      logger.error $ERROR_INFO.inspect
      render :json => {:title => 'Error', :message => 'Ran into an error updating the order. Please try again.'}
    end
  end

  private #----

    # Sort the collection.
    def collection
      @pages ||= end_of_association_chain.asc(:position)
    end

end