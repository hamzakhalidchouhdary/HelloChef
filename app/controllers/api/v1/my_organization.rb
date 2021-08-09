module API
  module V1
    class MyOrganization < Grape::API
      before { authenticate_admin }

      resource :organization do
        get "", root: :organization do
          if @current_user.organization_id
            my_organization = @current_user.organization 
            return {organization: my_organization}
          else
            return {error: 'no recode found', status: 400}
          end
        end

        desc 'create basic organization'
        params do 
          requires :name, type: String
          requires :address, type: String
        end
        post 'basic', root: :organization do
          p 'creating....'
          new_organization = Organization.new()
          new_organization.name = params[:name]
          new_organization.account_type = 'basic'
          new_organization.address = params[:address]
          new_organization.status = 'active'
          new_organization.price = 1200
          new_organization.price_type = 'fixed'
          p new_organization
          p 'saving'
          if new_organization.save
            User.unscoped.find(@current_user.id).update(organization_id: new_organization.id)
            return {organization: new_organization, status: 200}
          else
            return {error: 'something went wrong, try later', status: 400}
          end
        end

        desc 'create economy organization'
        params do 
          requires :name, type: String
          requires :address, type: String
        end
        post 'economy', root: :organization do
          new_organization = Organization.new
          new_organization.name = params[:name]
          new_organization.account_type = 'economy'
          new_organization.address = params[:address]
          new_organization.status = 'active'
          new_organization.price = 4500
          new_organization.price_type = 'fixed'
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
        end
        post 'pro', root: :organization do
          new_organization = Organization.new
          new_organization.name = params[:name]
          new_organization.account_type = 'pro'
          new_organization.address = params[:address]
          new_organization.status = 'active'
          new_organization.price = 0.5
          new_organization.price_type = 'percentage'
          if new_organization.save
            User.unscoped.find(@current_user.id).update(organization_id: new_organization.id)
            return {organization: new_organization, status: 300}
          else
            return {error: 'something went wrong, try later', status: 400}
          end
        end
      end
    end
  end
end
