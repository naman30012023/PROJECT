class UserController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: :add
    before_action :find_user, except: %i[add index]
    def new
        @user = User.new
    end

    #display all users
    def index
        u = User.all
        render json: u
    end


    def add
        u = User.create(user_params)
        render json: u
    end

    def update
        if(@current_user.id == @user.id)
             @current_user.bio = params[:bio] || @current_user.bio
             @current_user.profile_imageURL = params[:imageURl] || @current_user.profile_imageURL
             @current_user.save
             render json: @current_user
        else
            render text: 'Not Authorized to update this user'
        end
    end

    def delete
        render json: @current_user
        @current_user.destroy
    end



    private

    def find_user
        @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
        params.permit(:username, :email, :password, :bio, :profile_imageURL)
    end


end
