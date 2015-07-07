class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was succesffully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully deleted.'}
    end
  end

  def upvote
    @article = Article.find(params[:id])
    @article.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @article = Article.find(params[:id])
    @article.downvote_by current_user
    redirect_to :back
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def authorized_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to articles_path, notice: "There was a problem editing this article" if @article.nil?
    end
end
