class Sysadmin::PhotographersController < InheritedResources::Base
  layout 'admin'
  respond_to :html
  actions :all
  before_filter :authenticate_admin!
end