class UsersController < ApplicationController

    def index
        users = User.all
        render json: users
    end
    
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: {error: 'User not found'}, status: :unauthorized
        end
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private

    def render_unprocessable_entity(invalid)
        render json: {error: invalid.records.errors}, ststus: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
