class PortfoliosController < InheritedResources::Base
  actions :index, :show
  respond_to :html, :xml

  theme :active_theme

  # set the initial the background image
  def index
    index! do |format|
      format.html do
        redirect_to portfolio_path(active_photographer.portfolios.asc(:position).first)
        return
      end
      format.xml { render :template => '/galleries', :layout => false }
    end
  end

  def show
    show! do
      @page_title = "#{@portfolio.title} Portfolio"
      @page_keywords = @portfolio.keywords.blank? ? "#{@portfolio.title.downcase}, portfolio, photography, portraits, professional" : @portfolio.keywords
      @page_description = @portfolio.description
      @portfolios = active_photographer.portfolios.asc(:position)
      render :template => '/portfolio'
      return
    end
  end

  private #----

    def begin_of_association_chain
      active_photographer
    end

    # Sort the collection.
    def collection
      @portfolios ||= end_of_association_chain.asc(:position)
    end

end
