class Admin::CommentsController < ApplicationController
  active_scaffold :comments do |config|
    config.label = "Comentarios"
    list.columns.exclude :user
  end
end
