module API
  module V1
    module AuthHelpers
      def authenticate

        command = Command::AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          render json: { auth_token: command.result }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end

      def authenticate_request
        @current_user = Command::AuthorizeApiRequest.call(request.headers).result
        { 'error' => 'Not Authorized', 'status' =>  401 } unless @current_user
      end
    end
  end
end