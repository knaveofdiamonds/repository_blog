class PostsController < ApplicationController
  def index
    @posts = posts.all
  end

  def show
    @post = posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = posts.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if posts.save(@post)
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @post = posts.find(params[:id])
    @post.attributes = params[:post]

    if posts.save(@post)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @post = posts.find(params[:id])
    posts.destroy(@post)
    redirect_to posts_url
  end

  private

  def posts
    Repository.posts
  end
end
