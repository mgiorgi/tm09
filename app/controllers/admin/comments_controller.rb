class Admin::CommentsController < ApplicationController
  active_scaffold :comments do |config|
    config.label = "Comentarios"
    list.columns.exclude :user
    config.update.label = "Editar Comentario"
    config.update.link.label = "Editar Comentario"
    config.update.columns = [:title, :comment, :user_name, :user_email]
  end
end
