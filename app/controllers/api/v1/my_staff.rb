module API
  module V1
    class MyStaff < Grape::API
      before {authenticate_admin}

      resource :staff do

        desc 'return all staff'
        params do end
        get "", root: :staff do
          staff_list = Staff.all
          return {staff: staff_list, status: 200}
        end

        desc 'return specific staff'
        params do end
        get ":id", root: :staff do
          my_staff = Staff.find_by_id(params[:id])
          return {staff: my_staff, status: 200} if my_staff
          return {message: "no staff found", status: 300}
        end

        desc 'create new staff'
        params do
          requires :username, type: String
          requires :password, type: String
          requires :role, type: String
          requires :shop_id, type: String
        end
        post '/', root: :staff do
          new_staff = Staff.new(params)
          new_staff.organization_id = @current_user.organization_id
          if new_staff.save
            return {message: 'Staff has been created', staff: new_staff, status: 200}
          else
            return {error: 'something went wrong', status:400}
          end
        end

        desc 'update exisiting staff'
        params do
          requires :email, type: String
          # requires :password, type: String
          # requires :role, type: String
        end
        put '/', root: :staff do
          my_staff = Staff.find_by_email(params[:email])
          return {message: "no staff found", status: 300} unless my_staff
          my_staff.update(params)
          if my_staff.save
            return {message: 'Staff has been updated', staff: my_staff, status: 200}
          else
            return {error: 'something went wrong', status:400}
          end
        end

        desc 'remove a staff'
        params do
        end
        delete '/:id', root: :staff do
          my_staff = Staff.find_by_id(params[:id])
          if my_staff.destroy
            return {message: 'Staff has been deleted', staff: my_staff, status: 200}
          else
            return {error: 'something went wrong', status:400}
          end
        end
        
      end
    end
  end
end