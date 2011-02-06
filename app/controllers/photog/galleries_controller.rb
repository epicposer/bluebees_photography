class Photog::GalleriesController < Photog::HomeController
  inherit_resources
  actions :all, :except => :show
  respond_to :html, :json, :js

  # Set a default expires_on
  def new
    new! { @gallery.expires_on = 1.week.from_now.utc }
  end

  # Redirect to collection path on create.
  def create; create!{ collection_path }; end;

  # Redirect to collection path on update.
  def update; update!{ collection_path }; end;

  private #----

    # Sort the collection.
    def collection
      @galleries ||= end_of_association_chain.desc(:created_at)
    end

end

