class PostsController < ApplicationController

  def new
    @post = Post.new
    @posts = Post.all
  end

  def create
    if params[:post][:message].length > 0
     @post = current_user.posts.create(post_params)
    else
      flash[:notice] = "What the hell! The post can not be empty!"
    end
    redirect_to posts_url
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_url, alert: "Don't be too devilish! You can only burn your own posts!"
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully burnt in hell' }
        format.json { head :no_content }
      end
    end
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_url, alert: "Don't be too devilish! You can only edit your own posts!"
    else
      @post.update(post_params)
      redirect_to posts_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end
end
