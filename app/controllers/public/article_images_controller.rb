class Public::ArticleImagesController < ApplicationController
  def destroy
    begin
      @article = Article.find(params[:article_id])
    rescue
      render "index"
    end
    article_image = ArticleImage.find_by(article_id: @article.id)
    article_image.destroy
  end
end
