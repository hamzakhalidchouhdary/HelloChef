module API
  module V1
    module AuthHelpers
      extend ActiveSupport::Concern
      def generate_jwt

        command = Command::AuthenticateUser.call(params[:email], params[:password])
        if command.success?
          @auth_token = command.result
        else
          error!({error: command.errors[:user_authentication][0], status: 400})
        end
      end

      def authenticate
        command = Command::AuthorizeApiRequest.call(request.headers)
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end

      def authenticate_admin
        command = Command::AuthorizeApiRequest.call(request.headers, "admin")
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end

      def authenticate_staff
        command = Command::AuthorizeApiRequest.call(request.headers, "staff")
        @current_user = command.result
        error!({error: command.errors[:token][0], status: 400}) unless @current_user
      end

      def find_shop
        if params[:shop_id].present?
          @user_shop = Shop.find_by(id: params[:shop_id].to_i)
          error!({error: 'shop not found', status: 400}) unless @user_shop
        else
          error!({error: 'shop_id is missing'})
        end
      end

      def find_item
        @item = @user_shop.items.find{|e| e.id == params[:item_id].to_i}
        error!({error: 'item not found', status: 400}) unless @item
      end

      def find_shop_by_id(id)
        shop = @current_user.organization.shops.find{|e| e.id == id.to_i}
        error!({error: 'shop not found', status: 400}) unless shop
        return shop
      end

      def find_staff
        @staff = @user_shop.staffs.find{|e| e.id == params[:staff_id].to_i}
        error!({error: 'staff not found', status: 400}) unless @staff
      end

      def find_staff_by_id(id)
        staff = @current_user.organization.staff.find{|e| e.id == id.to_i}
        error!({error: 'staff not found', status: 400}) unless staff
        return staff
      end

      def find_staff_by_username(username)
        staff = @current_user.organization.staff.find{|e| e.username == username}
        error!({error: 'staff not found', status: 400}) unless staff
        return staff
      end

      def organization_exisit?
        error!({error: 'no organization found', status: 400}) unless @current_user.organization
        nil
      end

      def organization_exisit!
        error!({
          error: 'already exisit', 
          status: 400
        }) if @current_user.organization
        nil
      end

      def organization_active?
        error!({error: 'account suspended', status:400}) unless @current_user.organization.status == 'active'
        nil 
      end

      def shop_limit!
        error!( {
          warning: 'limit excessed',
          shop_count: @current_user.organization.shops.count,
          shop_limit: @current_user.organization.shop_limit,
          status: 500
        }) unless @current_user.organization.shops.count < @current_user.organization.shop_limit
        nil
      end
    end
  end
end