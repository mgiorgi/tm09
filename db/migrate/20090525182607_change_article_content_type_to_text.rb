class ChangeArticleContentTypeToText < ActiveRecord::Migration
  def self.up
    remove_column :articles, :content
    add_column :articles, :content, :text
  end

  def self.down
    remove_column :articles, :content
    add_column :articles, :content, :string
  end
end
