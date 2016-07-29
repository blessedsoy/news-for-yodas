class CommentsController < ApplicationController

  def create
    comment = Comment.create(content: comment_params["content"] , article_id: params[:article_id], user_id: current_user.id)

    redirect_to article_path(params[:article_id])

  end
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
