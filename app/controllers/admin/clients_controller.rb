class Admin::ClientsController < InheritedResources::Base
  layout 'admin'
  actions :all, :except => :show
  respond_to :html, :js
  before_filter :authenticate_photographer!
  
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
        render :json => {:title => 'Success', :message => 'Client was successfuly removed.'} 
      }
      failure.js { render :json => {:title => 'Error', :message => 'Ran into an error removing the client. Please try again.'} }
    end
  end
  
  def invite
    @client = Client.find(params[:id])
  end
  
  # send the client's welcome email
  def send_invite
    client = Client.find(params[:id])
    custom_message = params[:custom_message]
    client.deliver_invite!(@photographer, custom_message)
    flash[:notice] = "Client invitation sent."
    redirect_to admin_clients_path
  end
  
  private #-------
    # Defining the collection explicitly for paging
    def collection
      @clients ||= end_of_association_chain.paginate :page => params[:page], :per_page => 15
    end
    
end
