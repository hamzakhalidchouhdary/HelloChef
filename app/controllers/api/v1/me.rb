module API
  module V1
    class Me < Grape::API
      before { authenticate_admin }
      before { organization_exisit? }
      before { organization_active? }

      namespace :me do
        desc 'return current user and his organization'
        params do
          
        end
        get "", root: :me do
          return {
            user: @current_user, 
            organization:@current_user.organization,
            shops: @current_user.organization.shops,
            staffs:@current_user.organization.staffs, 
            status: 200 
          }
        end

      end
    end
  end
end