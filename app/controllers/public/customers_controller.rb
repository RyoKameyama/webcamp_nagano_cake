class Public::CustomersController < ApplicationController
  
def show
  @customer=Customer.find(params[:id])
end

def edit
  @customer=Customer.find(params[:id])
end

def update
  @customer=Customer.find(params[:id])
  if @customer.update(customer_params)
      flash[:notice] = "会員情報は正常に更新されました。"
    redirect_to customer_path(@customer)
  else
        render 'edit'
  end
end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
