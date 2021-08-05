module API
  module V1
    module AuthHelpers
      extend ActiveSupport::Concern
      def authenticate

        command = Command::AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          @auth_token = command.result
          # { auth_token: command.result }
        else
          error!({'massage' => command.errors[:user_authentication][0], 'status'=> 400})
          # error!(command.errors, 401)
          # { error: command.errors }#, status: :unauthorized
        end
      end

      def authenticate_request
        command = Command::AuthorizeApiRequest.call(request.headers)
        @current_user = command.result
        error!({"message" => command.errors[:token][0], "status" => 400}) unless @current_user
        # { 'error' => 'Not Authorized', 'status' =>  401 } unless @current_user
      end
    end
  end
end