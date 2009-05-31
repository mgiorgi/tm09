class AboutUsController < ApplicationController
  layout 'enter'
  def index
    article = Article.find_by_title(Article::Section::ABOUT_US)
    @content = article && !article.content.blank? ? CGI::unescape(article.content) : ''
    render :partial => 'articles/show', :layout => 'enter'
  end
end
