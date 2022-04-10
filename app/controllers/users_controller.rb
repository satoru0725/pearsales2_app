class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @products = Product.where(user_id: current_user.id)
    @products_variety = Product.where(user_id: current_user.id).select(:variety).distinct
    @products_count = Product.where(user_id: current_user.id).distinct.pluck(:variety)
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:shop_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :fax_number, :postal_code, :prefecture, :city, :town, :extended_address)
  end
end
