module API
  module V1
    class Organization < Grape::API
      before { authenticate_admin }

      resource :organization do
        get "", root: :organization do
          # users = User.all
          return {current_user: @current_user}
        end
      end
    end
  end
end
