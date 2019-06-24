class UsersController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
		@books = @user.books.all
		@newbook = Book.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		flash[:notice] = "successfully"
		redirect_to user_path(@user.id)
	    else
        render :edit
        end
	end

	def correct_user
      @user = User.find(params[:id])
      if current_user != @user
         redirect_to user_path(current_user)
      end
    end

	def index
		@users = User.all
		@user = User.find(current_user.id)
		@newbook = Book.new
	end

	private
    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
