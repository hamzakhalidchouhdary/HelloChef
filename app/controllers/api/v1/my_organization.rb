module API
  module V1
    class MyOrganization < Grape::API
      before { authenticate_admin }

      resource :organization do
        get "", root: :organization do
          return {organization: @current_user.organization} unless organization_exisit? && organization_active?
        end

        desc 'create basic organization'
        params do 
          requires :name, type: String
          requires :address, type: String
          requires :contact_no, type: String
          optional :email, type: String
        end
        post 'basic', root: :organization do
          organization_exisit!
          params[:status] = 'active'
          params[:shop_limit] = 1
          params[:account_type] = 'basic'
          new_organization = Organization.new(params)
          if new_organization.save
            User.unscoped.find(@current_user.id).update(organization_id: new_organization.id)
            return {
              organization: new_organization, 
              status: 200
            }
          else
            return {error: 'something went wrong, try later', status: 400}
          end
        end

        desc 'create economy organization'
        params do 
          requires :name, type: String
          requires :address, type: String
          requires :contact_no, type: String
          optional :email, type: String
        end
        post 'economy', root: :organization do
          organization_exisit!
          params[:status] = 'active'
          params[:shop_limit] = 5
          params[:account_type] = 'economy'
          new_organization = Organization.new(params)
          if new_organization.save
            User.unscoped.find(@current_user.id).update(organization_id: new_organization.id)
            return {organization: new_organization, status: 300}
          else
            return {error: 'something went wrong, try later', status: 400}
          end
        end

        desc 'create pro organization'
        params do 
          requires :name, type: String
          requires :address, type: String
          requires :contact_no, type: String
          optional :email, type: String
        end
        post 'pro', root: :organization do
          organization_exisit!
          params[:status] = 'active'
          params[:shop_limit] = 1000
          params[:account_type] = 'pro'
          new_organization = Organization.new(params)
          if new_organization.save
            User.unscoped.find(@current_user.id).update(organization_id: new_organization.id)
            return {organization: new_organization, status: 300}
          else
            return {error: 'something went wrong, try later', status: 400}
          end
        end

        desc 'update organization info'
        params do
          optional :name, type: String
          optional :address, type: String
          optional :contact_no, type: String
          optional :email, type: String
        end
        put '', root: :organization do
          organization_exisit?
          organization_active?
          return {
            message: 'recode updated', 
            organization: @current_user.organization, 
            status: 200
          } if @current_user.organization.update(params)
          return{error: 'something went wrong, try later', status: 400}
        end

        desc 'delete a organization'
        delete '', root: :organization do 
          organization_exisit?
          organization_active?
          ActiveRecord::Base.transaction do
            @current_user.organization.staffs.destroy_all
            @current_user.organization.shops.destroy_all
            @current_user.organization.destroy
            return{message: 'organization deleted', status:200}
          rescue ActiveRecord::RecordInvalid
            error!({error: 'something went wrong, try later', status: 400})
          end
        end

        desc 'return all shops'
        get '/shops', root: :organization do
          return {shops: @current_user.organization.shops, status: 200} if @current_user.organization.shops
          return {message: 'no shop found', status: 300}
        end

        desc 'delete all shops'
        delete '/shops', root: :organization do
          ActiveRecord::Base.transaction do
            @current_user.organization.shops.orders.destroy_all
            @current_user.organization.shops.items.destroy_all
            @current_user.organization.staffs.destroy_all
            @current_user.organization.shops.destroy_all
            return{message: 'shops deleted', status:200}
          rescue exp
            return {error: 'something went wrong, try later', status: 400}
          end
        end
      end
    end
  end
end
