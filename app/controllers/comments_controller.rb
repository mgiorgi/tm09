class CommentsController < ApplicationController
  before_filter :set_commentable, :only => [:create]
  def create
    titleStr = params[:comment][:title]
    commentStr = params[:comment][:comment]
    comment = Comment.new(:title => titleStr, :comment => commentStr, :user_name => params[:comment][:user_name], :user_email => params[:comment][:user_email])
    @commentable.comments << comment
    redirect_to (params[:redirect_path] || eval(params[:commentable_type].to_s.tableize + "_path"))
  end
  def index
  end
  private
  def set_commentable
    debugger
    @commentable = Object.const_get(params[:commentable_type]).find(params[:commentable_id].to_i)
  end
end
