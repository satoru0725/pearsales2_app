class CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update]
  def show
    @reserves = Reserve.where(customer_id: current_customer.id).order(reserve_on: :desc)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name,
                                     :last_name_kana, :first_name_kana, :phone_number, :fax_number, :postal_code, :prefecture, :city, :town, :extended_address)
  end
end
