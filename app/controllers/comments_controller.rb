class CommentsController < ApplicationController
  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @review = @article.comments.create(comment_params)
    redirect_to articles_path
  end

  private
  def comment_params
    params.require(:comment).permit(:thoughts, :rating)
  end

end
