class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @address_check = params[:order][:address_check]
    @total_price = 0
    @order = Order.new(order_params)
    if params[:order][:address_check] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_check] == "2"
      #@order_address = Address.find(params[:id])
      address = Address.find(params[:order][:address_id])
      #@order.address = address.postal_code + address.address + address.name
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    else
      address = Address.new
      #@order.address = address.postal_code + address.address + address.name
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    end
    @order.payment_method = params[:order][:payment_method]
  end

  def complete
  end

  def create
    cart_items = current_customer.cart_items
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.payment_method = params[:order][:payment_method]

    #if params[:order][:address_check] == "1"
      #order.address = current_customer.address
    #elsif params[:order][:address_check] == "2"
      #address = Address.find(params[:order][:address_id])
      order.postal_code = params[:order][:postal_code]
      order.address = params[:order][:address]
      order.name = params[:order][:name]

    if params[:order][:address_check]  == "3"
     address = Address.new
     address.postal_code = params[:order][:postal_code]
     address.address = params[:order][:address]
     address.name = params[:order][:name]
     address.customer_id = current_customer.id
     address.save
    # order.xxx = ???
    end
    order.shipping_cost = 800
    order.billed_amount = params[:order][:total_price].to_i + order.shipping_cost.to_i
    order.delivery_status = "入金待ち"
    order.save

    # cart itemをもとにorder detailを作成していく
     current_customer.cart_items.each do |cart_item|
     order_detail = OrderDetail.new
     order_detail.item_id = cart_item.item_id
     order_detail.order_id = order.id
     order_detail.production_status = "着手不可"
     order_detail.price = cart_item.item.price*1.1
     order_detail.amount = cart_item.amount
     order_detail.save
     end

    # cart itemを削除
     @cart_item = current_customer.cart_items
     @cart_item.destroy_all
     redirect_to orders_complete_path
  end

  def index
    @ships = Address.all
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :customer, :name, :postal_code, :address)
  end

end