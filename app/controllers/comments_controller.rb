class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_object, except: [:create]

  def create
    Comment.create comment_params
    redirect_to Post.find_by(id: comment_params[:post_id]), notice: "댓글이 성공적으로 등록되었습니다."
  end
  
  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to @post, notice: "댓글이 성공적으로 삭제되었습니다."
  end

  private

  def load_object
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :body, :post_id)
  end

end