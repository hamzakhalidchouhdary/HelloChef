module API
  module V1
    class MyStaff < Grape::API
      before { authenticate_admin }
      before { organization_exisit? }
      before { organization_active? }
      before { find_shop }

      resource :staff do
        desc 'return all staff'
        params do 
          requires :shop_id, type: String
        end
        get "", root: :staff do
          return {staff: @user_shop.staffs, status: 200}
        end

        desc 'return specific staff'
        params do 
          requires :shop_id, type: String
        end
        get ":staff_id", root: :staff do
          find_staff
          return {staff: @staff, status: 200}
        end

        desc 'create new staff'
        params do
          requires :shop_id, type: String
          requires :username, type: String
          requires :password, type: String
          requires :role, type: String
          requires :name, type: String
          requires :shop_id, type: String
          optional :salary, type: Integer
          optional :contact, type: String
          optional :address, type: String

        end
        post '/', root: :staff do
          new_staff = @current_user.organization.staffs.new(params)
          if new_staff.save
            return {message: 'Staff has been created', staff: new_staff, status: 200}
          else
            return {error: 'something went wrong', status:400}
          end
        end

        desc 'update exisiting staff'
        params do
          requires :shop_id, type: String
          optional :username, type: String
          requires :password, type: String
          optional :role, type: String
        end
        put ':staff_id', root: :staff do
          find_staff
          @staff.update(params.except(:staff_id))
          if @staff.save
            return {message: 'Staff has been updated', staff: @staff, status: 200}
          else
            return {error: 'something went wrong', status:400}
          end
        end

        desc 'remove a staff'
        params do
          requires :shop_id, type: String
        end
        delete '/:staff_id', root: :staff do
          find_staff
          return {message: 'Staff has been deleted', status: 200} if @staff.destroy
          return {error: 'something went wrong, try later', status:400}
        end

        desc 'remove all staff'
        params do
          requires :shop_id, type: String
        end
        delete '', root: :staff do
          return {message: 'Staffs has been deleted', status: 200} if @user_shop.staffs.destroy
          return {error: 'something went wrong, try later', status:400}
        end
        
      end
    end
  end
end