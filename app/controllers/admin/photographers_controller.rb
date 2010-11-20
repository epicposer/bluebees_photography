class Admin::PhotographersController < InheritedResources::Base
  layout 'admin'
  respond_to :html
  actions :show, :edit, :update
  before_filter :authenticate_photographer!
  
  # redirect to edit path on update instead of show
  def update
    update!{ edit_admin_photographer_path }
  end
  
end