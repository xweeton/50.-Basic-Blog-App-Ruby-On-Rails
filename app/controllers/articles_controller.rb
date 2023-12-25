class ArticlesController < ApplicationController
  # devise
  before_action :authenticate_user!, except: [:index, :show]
  
  # home page, all articles with pagination if no search, vice versa
  def index
    if params[:query].present?
      @articles = Article.search_by_title_and_body(params[:query]).paginate(page: params[:page], per_page: 10)
    else
      @articles = Article.all.paginate(page: params[:page], per_page: 3)
    end
  end

  # each article
  def show 
    @article = Article.find(params[:id])
  end

  # page of create new article
  def new
    @article = Article.new
  end

  # runner of create new article
  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      # redirect_to for redirect user to the specific view that rendered new article
      redirect_to @article
    else
      # if not, the same request(keep create the new article) every refresh
      render :new, status: :unprocessable_entity
    end
  end

  # page of edit article
  def edit
    @article = Article.find(params[:id])
    # if not the user who create this article, then redirect back to article page
    if @article.user != current_user
      redirect_to articles_path, alert: "You are not authorized to edit this article."
    end
  end

  # runner of edit article
  def update 
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      # set res code 422, if update fails, then render page of edit again
      render :edit, status: :unprocessable_entity
    end
  end

  # delete article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # then redirect to main path, or we can put articles_path to go articles page
    # status 303 see other(to tell the browser to see other page, this page moved)
    redirect_to root_path, status: :see_other
  end

  # for security, avoid get extra form fields and overwrite our sensitive data
  private
  def article_params
    params.require(:article).permit( :title, :body, :status, :image)
  end
end
