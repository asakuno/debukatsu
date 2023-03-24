class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to group_path(@comment.group)
    else
      redirect_to group_path(@comment.group)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(group_id: params[:group_id])
  end
end
