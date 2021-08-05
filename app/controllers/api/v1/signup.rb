module API
  module V1
    class Signup < Grape::API
      helpers V1::AuthHelpers

      namespace :signup do
        desc 'create new user'
        params do 
          requires :email, type: String
          requires :password, type: String
        end
        post '/' do
          new_user = User.new(:email => params[:email])
          new_user.password = params[:password]
          if new_user.save
            {'email' => params[:email], "password" => params[:password], "user" => new_user}
          else
            {'error' => 'can create user'}
          end
        end

      end
    end
  end
end