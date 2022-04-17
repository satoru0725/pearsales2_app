class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to root_path
    else
      render :new
    end
  end
end

private

def address_params
  params.require(:address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :fax_number, :postal_code, :prefecture, :city, :town, :extended_address).merge(customer_id: current_customer.id)
end
