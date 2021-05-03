class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @last_article = Article.last
    @articles = Article
      .all
      .eager_load(:user, :likes, :comments, :article_images)
      .page(params[:page])
      .per(5)
      .reverse_order
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.likes_count = 0
    if @article.save
      redirect_to article_path(@article.id), notice: "新しい記事を投稿しました。"
    else
      render "new"
    end
  end

  def edit
    begin
      @article = Article.find(params[:id])
      @article_images = ArticleImage.where(article_id: params[:id])
    rescue
      redirect_to "/", notice: "エラーが発生しました"
    end
  end

  def update
    begin
      @article = Article.find(params[:id])
      @article_images = ArticleImage.where(article_id: params[:id])
      
      @article.article_images = @article_images
    rescue
      redirect_to "/", notice: "エラーが発生しました"
    end
    if @article.update(article_params)
      redirect_to article_path(@article.id), notice: "編集を適用しました"
    else
      render "edit"
    end
  end

  def destroy
    if @article = Article.find(params[:id]).destroy
      redirect_to articles_path, notice: "記事を削除しました"
    else
      redirect_to "/", notice: "エラーが発生しました"
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id, article_images_images: [])
  end
end
