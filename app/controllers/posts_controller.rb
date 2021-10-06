class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]


  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if is_same_user(@post.user_id)
    else 
      redirect_to posts_url, notice: "You are not allow to edit this"
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    if is_same_user(post_params[:user_id])
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to posts_url, notice: "You are not allow to create this"
      return
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if (is_same_user(post_params[:user_id]))
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to posts_url, notice: "You are not allow to update this"
      return
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :msg)
    end

  def is_same_user(check_id)
    #puts "==============user_id #{check_id.class}" #string
    #puts "==============session #{(session[:user_id]).class}" #int
      if (session[:user_id].to_s == check_id.to_s) 
        return true
      else 
        return false
      end
    end
end
