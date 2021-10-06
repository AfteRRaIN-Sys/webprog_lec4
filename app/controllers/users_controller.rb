class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy] #check_user
  before_action :check_login, only: %i[index new create]
  before_action :is_same_user, only: %i[show edit update delete]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if (check_login)
    else 
      return false
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else 
        #
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." } #if requested format = html
        format.json { render :show, status: :ok, location: @user } #if requested format = json
      else
        format.html { render :edit, status: :unprocessable_entity } #unprocess of html(error 422)
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @temp = nil
    @temp = @user
    @user.destroy
    #respond_to do |format|
     # format.html { redirect_to users_url, notice: "User was successfully destroyed." }
     # format.json { head :no_content }
    #end
  end

  def create_fast
    @re_name = params[:name]
    @re_email = params[:email]
    User.create(name:@re_name, email:@re_email)
  end

  def main
    @ok = params[:ok]
    #puts "------param ok is #{@ok}"
    session[:user_id] = nil
  end

  def check_user
    @logging_user = User.find_by(email: params[:email])
    if (@logging_user == nil || @logging_user.authenticate(params[:pass]) == false) #authenticate return false
      redirect_to "/main?ok=error", notice:"Email or Password is not correct!"
      #after redirect, the program still execute the next lines till all func done then redirect
      if (@logging_user) 
        session[:user_id] = nil
      end
    else 
      redirect_to "/users/#{User.find_by(email: params[:email]).id}", notice: "Welcome Back!! #{@logging_user.email}"
      
      #after login => create cookie
      session[:user_id] = @logging_user.id
    end

    #auto render here if there is no redirect or render
  end

  def create_post
    @user = User.find_by(id: params[:create_id])
    if (is_same_user)
      @post = Post.create(user_id: params[:create_id])
      puts @post.user_id
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def check_login
      #direct :login do
      #  "http://localhost:3000/main"
      #end
      if (session[:user_id]) 
        return true
      else 
        redirect_to "http://localhost:3000/main", notice: "Please Login!"
        #return false
      end
    end

    def is_same_user
      if (@user == nil || session[:user_id] != @user.id) 
        if (@user == nil) 
          redirect_to "http://localhost:3000/main", notice: "You are not logged in"
        else
          redirect_to "http://localhost:3000/main", notice: "You are not permitted to this content"
        end
      else
        return true
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      #dont for get to put param in this!!!!!!!!!!!!!!
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :pass, :password)
    end

end
