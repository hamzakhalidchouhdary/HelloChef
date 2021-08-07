module API
  module V1
    module AuthHelpers
      extend ActiveSupport::Concern
      def generate_jwt

        command = Command::AuthenticateUser.call(params[:email], params[:password])
        if command.success?
          @auth_token = command.result
        else
          error!({error: command.errors[:user_authentication][0], status: 400})
        end
      end

      def authenticate
        command = Command::AuthorizeApiRequest.call(request.headers)
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end

      def authenticate_admin
        command = Command::AuthorizeApiRequest.call(request.headers, "admin")
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end

      def authenticate_staff
        command = Command::AuthorizeApiRequest.call(request.headers, "staff")
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end
    end
  end
end