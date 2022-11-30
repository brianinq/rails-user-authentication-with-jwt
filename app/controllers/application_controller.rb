class ApplicationController < ActionController::API
    wrap_parameters false
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload,"app secret")
    end
    def auth_header
        request.headers["Authorization"]
    end
    def decode_token
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, "app secret")
            rescue JWT::DecodeError
                nil
            end
        end
    end
    def curent_user
        if decode_token
            user_id = decode_token[0]['user_id']
            user = User.find_by(id: user_id)
        end
    end
    def logged_in?
        !!curent_user
    end
    def authorized
        render json: {error: "Please log in"}, status: :unauthorized unless logged_in?  
    end
end
