class UsersController < ApplicationController
  before_action :authenticate_user!
   before_action :ensure_current_user, {only: [:edit,:update,:destroy]}



  def new
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
    @posted_book = Book.where(user_id: params[:id])
    @books = @posted_book.all
    @book = Book.new
  end
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to "/users/#{current_user.id}"
      else
            render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def  ensure_current_user
        @user = User.find(params[:id])
     if @user.id != current_user.id
        redirect_to user_path(current_user.id)
     end
  end
end
