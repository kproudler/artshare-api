class UsersController < ApplicationController
#   before_action :require_not_logged_in!, only: [:create, :new]
#   Leaving disabled for demo
#   before_action :require_logged_in!, only: [:show]
#   before_action :require_current_user!, except: [:create, :new]

    def index
        case
            when params[:query]
                @user = User.where('username LIKE ?', "%#{params[:query]}%")
            else
                @user = User.all
            end
        render :index
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: @user
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            render json: @user
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end


    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end


end