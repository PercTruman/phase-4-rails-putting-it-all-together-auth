class UsersController < ApplicationController

skip_before_action :authorize, only: :create
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
     end

    def show
       render json: @current_user
    end

    private 

    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
