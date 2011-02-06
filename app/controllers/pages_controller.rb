class PagesController < InheritedResources::Base
  actions :show
  respond_to :html

  theme :active_theme

  def show
    show! do
      @page_title = @page.title
      @page_keywords = @page.keywords.blank? ? "#{@page.title.downcase}, photography, portraits, professional" : @page.keywords
      render :template => '/page'
      return
    end
  end

  private #----

    def begin_of_association_chain
      active_photographer
    end

end