class BooksController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]

	def create
        # ストロングパラメーターを使用
        @newbook = Book.new(book_params)
        @newbook.user_id = current_user.id
        if @newbook.save
        flash[:notice] = "successfully"
        redirect_to book_path(@newbook.id)
        else
        @user = @newbook.user
        @books = @user.books.all
        render 'users/show'
        end
    end

    def show
    	@book = Book.find(params[:id])
        @user = @book.user
        @newbook = Book.new
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "successfully"
        redirect_to book_path(@book)
        else
        render :edit
    end
    end

    def index
        @user = User.find(current_user.id)
        @newbook = Book.new
        @books = Book.all
    end

    def correct_user
      book = Book.find(params[:id])
      user = book.user
      if current_user != user
         redirect_to books_path
      end
    end

    private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
