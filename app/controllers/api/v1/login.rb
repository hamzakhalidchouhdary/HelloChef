module API
  module V1
    class Login < Grape::API

      namespace :login do
        desc 'Return list of books'
        params do
          requires :email, type: String
          requires :password, type: String 
        end
        post "/", root: :login do
          generate_jwt
          return {token: @auth_token, status: 200} if @auth_token
          return {error: "something went wrong", status: 400}
        end

      end
    end
  end
end