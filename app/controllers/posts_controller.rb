class PostsController < ApplicationController
 before_action :authenticate_user!
  before_action :load_object, except: [:index, :new, :create]

  def index
    if params[:type]&.to_sym == :owns # 내가 쓴 게시글
      @posts = Post.where(user: current_user)
    elsif params[:type]&.to_sym == :likes # 내가 좋아하는 게시글
      @posts = Post.where(id: current_user.likes.map(&:post_id))
    elsif params[:type]&.to_sym == :comments
      @posts = Post.where(id: current_user.comments.map(&:post_id))
    else
      @posts = Post.ransack(params[:q]).result # 모든 게시글 or 검색내용
    end
    @posts = @posts.order(updated_at: :desc).page(params[:page]).per(4)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create posts_params
    redirect_to posts_path, notice: "게시글을 성공적으로 등록하였습니다."
  end

  def show
    @comments = @post.comments.page(params[:page]).per(3)
    @like = @post.likes.find_by(user: current_user)
  end

  def edit;end

  def update
    @post.update posts_params
    redirect_to posts_path, notice: "게시글을 성공적으로 수정하였습니다."
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "게시글을 성공적으로 삭제하였습니다."
  end

  def toggle_like
    @like = @post.likes.find_or_initialize_by(user: current_user)
    @like.new_record? ? @like.save : @like.destroy
    redirect_to @post, notice: "#{@like.destroyed? ? "좋아요를 취소했습니다." : "좋아요를 눌렀습니다."}"
  end

  private
  
  def posts_params
    params.require(:post).permit(:title, :content, :user_id, :image)
  end

  def load_object
    @post = Post.find_by(id: params[:id])
  end
end