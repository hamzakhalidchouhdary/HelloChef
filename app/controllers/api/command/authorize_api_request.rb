module API
  module Command
    class AuthorizeApiRequest

      prepend SimpleCommand
      
      def initialize(headers = {}, user_type = '')
      @headers = headers
      @user_type = user_type
    end
    
    def call
      if @user_type === 'admin'
        admin_user
      elsif @user_type === 'staff'
        staff_user
      else
        user
      end
    end
    
    private
    
    attr_reader :headers
    
      def user
        if decoded_auth_token
          @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token[:role] === 'admin'
          @user ||= Staff.find(decoded_auth_token[:user_id]) if decoded_auth_token[:role] != 'admin'
        end
        @user || errors.add(:token, 'access denied') && nil
      end

      def admin_user
        @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token #&& decoded_auth_token[:role] === 'admin'
        @user || errors.add(:token, 'access denied') && nil
      end

      def staff_user
        @user ||= Staff.find(decoded_auth_token[:user_id]) if decoded_auth_token && decoded_auth_token[:role] != 'admin'
        @user || errors.add(:token, 'access denied') && nil
      end

      def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      end

      def http_auth_header
        if headers['Authorization'].present?
          return headers['Authorization'].split(' ').last
        else
          errors.add(:token, 'missing token')
        end
        nil
      end
    end
  end
end