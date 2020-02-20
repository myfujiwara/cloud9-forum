class PostsController < ApplicationController
  before_action :authorize
  
  def top
    @posts = Post.all
    @posts = @posts.includes(:post_comments).where("tweet like ? or comment like ?", "%#{params[:word]}%", "%#{params[:word]}%").references(:post_comments)
    @posts = @posts.order("posts.id desc")
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿しました。"
      redirect_to ('/')
    else
      flash[:danger] = "投稿に失敗しました。"
      redirect_to new_post_path and return
    end
  end
  
  def comment
    @post = Post.find(params[:id])
    @post.post_comments.create(post_comment_params)
    flash[:success] = "コメントしました。"
    redirect_to('/')
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment).merge(user_id: current_user.id)
  end
    
  private
  def post_params
    params.require(:post).permit(:tweet, :title, category_ids: []).merge(user_id: current_user.id)
  end
end