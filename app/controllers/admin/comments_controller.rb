class Admin::CommentsController < InheritedResources::Base
  layout 'admin'
  respond_to :html
  before_filter :authenticate_photographer!
  actions :index, :show, :new, :create
  belongs_to :client, :booking, :booking_photo
  
  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = 'Comment was added successfuly.'
        redirect_to parent_path
      end
      failure.html do
        flash[:warning] = 'Ran into an error adding your comment. Please try again.'
        redirect_to parent_path
      end
    end
  end
  
  private #-------
    # Defining the collection explicitly for paging
    def collection
      @comments ||= end_of_association_chain.order_by(:created_at.desc).paginate :page => params[:page], :per_page => 10
    end
  
end