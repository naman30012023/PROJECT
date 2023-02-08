class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
        @user = User.new
    end

    def index
        u = User.all
        render u
    end


    def add
        u = User.create(user_params)
        render json: u
    end


    def user_params
        params.permit(:username)
    end


end
