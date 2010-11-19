class Admin::PhotographersController < InheritedResources::Base
  layout 'admin'
  respond_to :html
  actions :show, :edit, :update
  before_filter :authenticate_photographer!
    
end