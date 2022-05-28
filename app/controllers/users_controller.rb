class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.all
    @products = Product.all
  end

  def show
    @user = User.find(params[:id])
    @products = Product.where(user_id: params[:id])
    @products_variety = Product.where(user_id: params[:id]).select(:variety).distinct
    @products_count = Product.where(user_id: params[:id]).distinct.pluck(:variety)
    @order_items = OrderItem.where(shop_name: @user.shop_name).order(created_at: 'DESC')
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
    params.require(:user).permit(:shop_name, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number,
                                 :fax_number, :postal_code, :prefecture, :city, :town, :extended_address)
  end
end
