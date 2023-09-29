module API
  module V1
    class MyItem < Grape::API
      before { authenticate_admin }
      before { find_shop }

      resource :item do
        desc 'return items of specified item_id'
        params do
          requires :shop_id, type: String
        end
        get '/', root: :item do 
          return{
            message: 'item found',
            items: @user_shop.items,
            status: 200
          }
        end

        desc 'return items of specified item_id'
        params do
          requires :shop_id, type: String
        end
        get ':item_id', root: :item do
          find_item
          return{
            message: 'item found',
            item: @item,
            status: 200
          }
        end

        desc 'create items of specified shop'
        params do 
          requires :shop_id, type: String
          requires :title, type: String
          requires :description, type: String
          requires :price, type: Integer
          # optional :currency, type: String, default: 'PKR'
          requires :created_by_id, type: String
          optional :icon, type: String

        end
        post '', root: :item do
          new_item = @user_shop.items.new(params)
          return{
            message: 'item found',
            items: new_item,
            status: 200
          } if new_item.save
          return {error: 'something went wrong, try later', status: 400}
        end

        desc 'update items of specified item_id'
        params do 
          requires :shop_id, type: String
          optional :title, type: String
          optional :description, type: String
          optional :price, type: Integer
          optional :currency, type: String
          optional :staff_id, type: String
          optional :icon, type: String

        end
        put ':item_id', root: :item do
          find_item
          return {
            message: 'item updated',
            item:@item,
            status: 200
          } if @item.update(params.except!(:item_id))
          return{
            error: 'something went wrong, ty later',
            status: 400
          }
        end

        desc 'delete a specific item'
        params do
          requires :shop_id, type: String
        end
        delete ':item_id', root: :item do
          find_item
          return {
            message: 'item deleted',
            status: 200
          } if @item.destroy
          return{
            error: 'something went wrong, ty later',
            status: 400
          }
        end

        desc 'delete all items'
        params do
          requires :shop_id, type: String
        end
        delete '', root: :item do
          return {
            message: 'items deleted',
            status: 200
          } if @user_shop.items.destroy_all
          return {
            error: 'something went wrong, try later',
            status: 400
          }
        end
      end
    end
  end
end