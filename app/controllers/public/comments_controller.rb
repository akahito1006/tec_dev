class Public::CommentsController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    comment = current_user.comments.new(comment_params)
    comment.article_id = article.id
    comment.save
  end
  
  def destroy
    article = Article.find(params[:id])
    p article
    comment = current_user.comments.find_by(article_id: article.id)
    comment.destroy
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end