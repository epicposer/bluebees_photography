class Photog::PhotographersController < Photog::HomeController
  inherit_resources
  respond_to :html
  actions :show, :edit, :update

  # Redirect to edit path on update instead of show
  def update; update!{ edit_photog_photographer_path }; end;

end