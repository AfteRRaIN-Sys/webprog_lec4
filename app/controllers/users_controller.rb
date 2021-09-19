class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy] #check_user

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
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
    puts "------param ok is #{@ok}"
  end

  def check_user
    #works with main
    #redirect_to "https://www.google.com/"
    #puts "----------------"
    #puts params[:email]
    @tmp = User.find_by(email: params[:email]).pass rescue nil
    if (@tmp == nil || @tmp != params[:pass])
      redirect_to "/main?ok=error"
    else redirect_to "/users/#{User.find_by(email: params[:email]).id}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :pass)
    end
end
