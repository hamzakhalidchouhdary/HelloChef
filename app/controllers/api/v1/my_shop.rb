module API
  module V1
    class MyShop < Grape::API
      before { authenticate_admin }
      before { organization_exisit? }
      before { organization_active? }

      resource :shop do
        desc 'return shop specified'
        get ':shop_id', root: :shop do
          find_shop
          return{
            message: 'shop found',
            shop: @user_shop,
            status: 200
          }
        end

        desc 'create new shop'
        params do
          requires :name, type: String
          requires :address, type: String
        end
        post '/', root: :shop do
          shop_limit!
          new_shop = @current_user.organization.shops.new(params)
          if new_shop.save
            return {
              message: 'shop created', 
              shop: new_shop, 
              status: 200
            }
          else
            return {error: 'something went wrong', status: 400}
          end
        end

        desc 'update shop info'
        params do
          optional :name, type: String
          optional :address, type: String
          optional :id, type: String
        end
        put ':shop_id', root: :shop do
          find_shop
          if @user_shop.update(params.except(:shop_id))
            return {
              message: 'shop updated',
              updated_shop: @user_shop,
              status: 200
            }
          else
            return {
              error: 'something went wrong',
              status: 400
            }
          end
        end

        desc 'delete a shop'
        params do
        end
        delete ':shop_id', root: :shop do
          find_shop
          ActiveRecord::Base.transaction do
            @user_shop.orders.destroy_all
            @user_shop.items.destroy_all
            @user_shop.staffs.destroy_all
            @user_shop.destroy
            return{message: 'shop deleted', status:200}
          rescue exp
            error!({error: 'something went wrong, try later', status: 400})
          end
        end
      end
    end
  end
end