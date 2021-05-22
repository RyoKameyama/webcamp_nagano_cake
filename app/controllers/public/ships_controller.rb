class Public::ShipsController < ApplicationController
def index
    @ships=current_customer.addresses
    @address=Address.new
end

def create
    #@ship = Address.new(ship_params)
    @address = Address.new(ship_params)
    #@ship.customer_id = current_customer
    @address.customer_id = current_customer.id
    #if @ship.save
    if @address.save
      redirect_to ships_path
    else
      render :index
    end
end

def edit
    @ship=Address.find(params[:id])
end

def update
    @ship=Address.find(params[:id])
    if @ship.update(ship_params)
      redirect_to ships_path(current_customer)
    else
      render 'edit'
    end
end

def destroy
    @ship=Address.find(params[:id])
    @ship.destroy
    redirect_to ships_path(current_customer)
end

private

  def ship_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
