class HomeController < ApplicationController
  layout 'enter'
  caches_page :index
  def index
    article = Article.find_by_title(Article::Section::INICIO)
    @content = article && !article.content.blank? ? article.final_content : ''
    if @content.blank?
      render :partial => 'shared/under_construction', :layout => 'enter'
    else
      render :partial => 'articles/show', :layout => 'enter'
    end
  end
  def public_reference_materials
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name = ?', Category::PUBLIC_CATEGORY])
  end
end
