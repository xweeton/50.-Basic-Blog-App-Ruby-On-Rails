class CommentsController < ApplicationController
  def create
    # nested in article, so need follow find id of article first then comment create
    @article = Article.find(params[:article_id])
    # to connect comments with the currently logged-in user when creating a new comment
    @comment = @article.comments.build(comment_params.merge(user_id: current_user.id))
    if @comment.save
    redirect_to article_path(@article)
  else
    puts @comment.errors.full_messages
    redirect_to article_path(@article), status: :see_other
  end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    # after destroy/delete then back to article page
    # status 303 see other(to tell the browser to see other page, this page moved)
    redirect_to article_path(@article), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
