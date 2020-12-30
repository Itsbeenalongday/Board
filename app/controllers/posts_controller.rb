class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_object, except: [:index, :new, :create]

  def index
    if params[:type]&.to_sym == :owns # 내가 쓴 게시글
      @posts = Post.where(user: current_user)
    elsif params[:type]&.to_sym == :likes # 내가 좋아하는 게시글
      liked_posts = []
      current_user.likes.map do |object|
        liked_posts << object[:post_id]
      end
      @posts = Post.where(id: liked_posts) 
    else
      @posts = Post.all # 모든 게시글
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
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(3)
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
    @like = @post.likes.find_by(user: current_user)
    @like ? @like.destroy : Like.create(post: @post, user: current_user)
    redirect_to @post
  end

  private
  
  def posts_params
    params.require(:post).permit(:title, :content, :user_id, :image)
  end

  def load_object
    @post = Post.find_by(id: params[:id])
  end

end
