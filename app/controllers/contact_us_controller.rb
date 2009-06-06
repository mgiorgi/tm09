class ContactUsController < ApplicationController
  layout 'enter'
  def index
    article = Article.find_by_title(Article::Section::CONTACT_US)
    @content = article && !article.content.blank? ? article.final_content : ''
    if @content.blank?
      render :partial => 'shared/under_construction', :layout => 'enter'
    else
      render :partial => 'articles/show', :layout => 'enter'
    end
  end
end
