class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end



  def create
   @user = User.create(user_params)
    if @user && @user.password == @user.password_confirmation
      session[:user_id] = @user.id
      flash[:notice] = "Successfully Created Account"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to '/users/new'
    end

  end

  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
