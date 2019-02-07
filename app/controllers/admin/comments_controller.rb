class Admin::CommentsController < Admin::ApplicationController
  def index
    @comments = Comment.all.order('created_at desc')
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def toggle
    @comment = Comment.find(params[:id])
    @comment.toggle!
    redirect_to [:admin, @comment]
  end

  def mark_as_spam
    @comment = Comment.find(params[:id])
    @comment.mark_as_spam!
    redirect_to [:admin, @comment]
  end
end
