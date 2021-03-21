class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
  
def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = (current_user.id)
      if @book.save
       flash[:notice] = "You have creatad book successfully."
       redirect_to book_path(@book.id)
      else
       @books = Book.all
       render "index"
      end
end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new

  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = User.find(@book_show.user_id)
  end
  def edit
    @book = Book.find(params[:id])
    unless current_user == @book.user 
      redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:notice] = "You have update book successfully."
      redirect_to book_path(@book.id)
     else
       render "edit"
     end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def  ensure_current_user
      @book = Book.find(params[:id])
    if @book.user_id != current_user.id
        redirect_to books_path
    end
  end
end
