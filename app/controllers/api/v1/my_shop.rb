module API
  module V1
    class MyShop < Grape::API
      before { authenticate_admin }

      resource :shop do
        desc 'return all shops'
        get '', root: :shop do
          return {shops: @current_user.organization.shops, status: 200} if @current_user.organization.shops
          return {message: 'no recode found', status: 300}
        end

        desc 'create new shop'
        params do
          requires :name, type: String
          requires :address, type: String
        end
        post '', root: :shop do
          new_shop = @current_user.organization.shops.new(params)
          if new_shop.save
            return {message: 'shop created', shop: new_shop, status: 200}
          else
            return {error: 'something went wrong', status: 400}
          end
        end
      end
    end
  end
end