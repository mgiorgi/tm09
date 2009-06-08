class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article
 # If our sweeper detects that a Post was created call this
  def after_create(article)
    expire_cache_for(article)
  end
  # If our sweeper detects that a Post was updated call this
  def after_update(article)
    expire_cache_for(article)
  end
  # If our sweeper detects that a Post was deleted call this
  def after_destroy(article)
    expire_cache_for(article)
  end
  private
  def expire_cache_for(article)
    case article.title
    when Article::Section::CONTACT_US
      expire_page contact_us_path
    when Article::Section::ABOUT_US
      expire_page about_us_path
    when Article::Section::TALLERES_INICIO
      expire_page groups_path
    when Article::Section::INICIO
      expire_page '/index.html'
    else
      expire_page article_path(article)
    end
  end
end
