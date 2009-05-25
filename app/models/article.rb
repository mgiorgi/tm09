class Article < ActiveRecord::Base
  class Section
    INICIO = 'Inicio'
  end
  attr_accessor :body
  def body
    CGI::unescape(self.content) unless self.content.blank?
  end
  def body=(value)
    self.content = CGI::escape(value)
  end
end
