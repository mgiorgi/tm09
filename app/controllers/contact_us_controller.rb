class ContactUsController < ApplicationController
  layout 'enter'
  def index
    article = Article.find_by_title(Article::Section::CONTACT_US)
    @content = article ? CGI::unescape(article.content) : ''
    render :partial => 'articles/show', :layout => 'enter'
  end
end
