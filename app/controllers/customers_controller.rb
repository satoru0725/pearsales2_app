class CustomersController < ApplicationController
  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :fax_number, :postal_code, :prefecture, :city, :town, :extended_address)
  end
end
