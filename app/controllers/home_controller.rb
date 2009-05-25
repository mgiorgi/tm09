class HomeController < ApplicationController
  layout 'enter'
  def index
    article = Article.find_by_title(Article::Section::INICIO)
    @content = article ? CGI::unescape(article.content) : ''
  end
  def public_reference_materials
    @reference_materials = ReferenceMaterial.find(:all, :include => [:categories], :conditions => [ 'categories.name = ?', Category::PUBLIC_CATEGORY])
  end
end
