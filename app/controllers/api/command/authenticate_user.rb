module API
  module Command
    class AuthenticateUser

      prepend SimpleCommand

      def initialize(email, password)
        @email = email
        @password = password
      end

      def call
        JsonWebToken.encode(user_id: user.id, role: user.role) if user
      end

      private

      attr_accessor :email, :password

      def user
        user = User.find_by(id: 1 )
        # user = User.all
        p user
        # user.role = 'admin' if user
        # user = Staff.unscoped.find_by_username(email) unless user
        # return user if user && user.authenticate(password)
        # errors.add(:user_authentication, 'incorrect password') if user
        # errors.add(:user_authentication, 'user not register')
        # nil
      end

    end
  end
end