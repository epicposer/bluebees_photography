class GalleryPhotosController < InheritedResources::Base
  belongs_to :gallery
  actions :index, :show
  respond_to :html
  before_filter :authenticate_client!
  before_filter :require_active_galleries!

  theme :active_theme

  def index
    index! {
      return unless require_ownership and not_expired
    }
  end

  def show
    show! {
      return unless require_ownership and not_expired
    }
  end


  private #--------

    # make sure the client is logged in and owns the galleries / photos they are trying to access
    def require_ownership
      if current_client.id == @gallery.client.id
        return true
      else
        # doesn't own the parent gallery
        flash[:warning] = 'You can only view galleries and photos associated with your account.'
        redirect_to client_galleries_path # back to the galleries they DO own
        return false
      end
    end

    # check if the parent gallery has expired (true = hasn't expired, false = has expired)
    def not_expired
      (@gallery.expires_on.blank? or @gallery.expires_on > Date.today)
    end

end
