class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        user = User.find_by(username: auth_params[:username])
        if user&.authenticate(auth_params[:password])
            token = encode_token(user_id: user.id)
            render json: {user: UserSerializer.new(user), jwt: token}, status: :accepted
        else
            render json: {error: "Invalid username or password"}, status: :unauthorized
    end


    private
    def auth_params
        params.permit(:username, :password)
    end
end
