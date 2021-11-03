class PostsController < ApplicationController
  def index
    @post_from_db = Post.all
  end

  def show
    @post_from_db = Post.find(params[:id])
  end

  def new
    @post_from_db = Post.new
  end

  def create
    @post_from_db = Post.new(post_params)

    if @post_from_db.save
      redirect_to @post_from_db
    else
      render :new
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
