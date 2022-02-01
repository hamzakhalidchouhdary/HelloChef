module API
  module V1
    class Signup < Grape::API

      namespace :signup do
        desc 'create new user'
        params do 
          requires :email, type: String
          requires :password, type: String
        end
        post '/', root: :signup do
          new_user = User.new(params)
          if new_user.save
            generate_jwt
            return {token: @auth_token, status: 200} if @auth_token
            return {error: "something went wrong", status: 400}
          else
            return {error: 'can create user', status: 400}
          end
        end

      end
    end
  end
end