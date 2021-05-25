class Admin::HomesController < ApplicationController
  def top
    if params[:key] == "from_customer"
    @customer = Customer.find(params[:specific_customer_id])
    @orders = @customer.orders.page(params[:page]).reverse_order
    else
    @orders = Order.page(params[:page]).reverse_order
    end
  end

end
