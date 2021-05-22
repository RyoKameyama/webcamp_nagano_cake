class Public::CartItemsController < ApplicationController

def create
  #もし送られてきたアイテムがすでにカートに存在する場合、
  #既存のカート内アイテムの数量のみを追加する。
  #else 以下記述済み
   @cart_item=CartItem.new(cart_item_params)
   #@cart=CartItem.new(cart_item_params)
   @cart_item.customer_id=current_customer.id
   @cart_items=current_customer.cart_items
   if @cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      existing_item = @cart_items.find_by(item_id: params[:cart_item][:item_id])
      #元々あったカート内のアイテムのうち1つのアイテム
      #where/ 複数条件を満たす複数のオブジェクト
      #find_by/ 複数条件を満たす1つのオブジェクト
      #find/ 1つの条件を満たす1つのオブジェクト
      existing_item.amount += params[:cart_item][:amount].to_i
      existing_item.update(amount: existing_item.amount)
   @cart_item = existing_item
   else
     @cart_item.save
   end
    redirect_to cart_items_path
end

def index
  @cart_items=CartItem.all
end

def update
  @cart_item=CartItem.find(params[:id])
  @cart_item.update(cart_item_params)
    redirect_to cart_items_path
end

def destroy
  @cart_item=CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to cart_items_path
end

def destroy_all
  @cart_item=CartItem.all
  @cart_item.destroy_all
  redirect_to cart_items_path
end


  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end